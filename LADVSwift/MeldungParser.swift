//
//  MeldungParser.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 02.07.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import SwiftSoup

struct MeldungParser {
    init() {}

    public func parse(html: Data) throws -> [MeldungPerAge] {
        let string = String(data: html, encoding: .utf8)!
        return try parse(html: string)
    }
    
    public func parse(html: String) throws -> [MeldungPerAge] {
        let document: Document = try SwiftSoup.parse(html.replacingOccurrences(of: "space", with: ""))
        return try parse(document: document)
    }

    func parse(document: Document) throws -> [MeldungPerAge] {
        var result = [MeldungPerAge]()
        let disciplinDlvIDs = Set(Disciplin.all.map { $0.code })
        let anchors = try document.getElementsByClass("anchor")
        for age in Age.all {
            guard let ageHeadline = try document.getElementById(age.ladvID) else {
                continue
            }
            var disciplins = [AttendingDisciplins]()
            let disciplinAnchors = anchors.filter({
                guard let id = try? $0.attr("id"), id != age.dlvID, $0.hasClass("anchor"), id.contains(age.ladvID) else {
                    return false
                }
                let diciplin = String(id.trimmingPrefix(age.ladvID))
                return disciplinDlvIDs.contains(diciplin)
            })

            for disciplinAnchor in disciplinAnchors {
                let dlvID = try String(disciplinAnchor.attr("id").trimmingPrefix(age.ladvID))
                let disciplin = Disciplin(dlvID: dlvID)
                var meldungen: [Meldung] = []

                let index = ageHeadline.siblingElements().firstIndex(of: disciplinAnchor)
                let rows = Array(disciplinAnchor.siblingElements().suffix(from: index!))

                guard let row = rows[safe: 2], try row.className() == "row" else {
                    disciplins.append(AttendingDisciplins(requiredPerformance: nil, disciplin: disciplin, attendees: []))
                    continue
                }
                let athleteRows = try row.getElementsByClass("einzel block ")
                for athleteRow in athleteRows {
                    guard let meldung = try parseEinzelMeldung(athleteRow: athleteRow) ?? parseTeamMeldung(meldungRow: athleteRow) else {
                        continue
                    }
                    meldungen.append(meldung)

                }
                disciplins.append(AttendingDisciplins(requiredPerformance: nil, disciplin: disciplin, attendees: meldungen))
            }

            result.append(MeldungPerAge(
                age: age,
                disciplins: disciplins
            ))
        }
        return result
    }

    private func parseEinzelMeldung(athleteRow: Element) throws -> Meldung? {
        guard let athlete = try athleteRow.getElementsByTag("a").first(),
              let age = try athleteRow.getElementsByTag("small").first(),
              let verein = try athleteRow.getElementsByClass("col-12 overflow-hidden text-nowrap tnsmall").first(),
              let performanceElement = try athleteRow.getElementsByClass("col-12 text-right").first(),
              let number = try athleteRow.getElementsByClass("col-2 text-right").first()?.html()  else {
            return try parseEinzelMeldungOneLADV(athleteRow: athleteRow)
        }
        let ageAndNation = try age.html().split(separator: " ")
        let yearOfBirth: Int = Int(ageAndNation[0])!
        let regionText = try verein.html().suffix(5)
        let regionId = regionText.replacingOccurrences(of: " (", with: "").replacingOccurrences(of: ")", with: "")
        let clubName = try verein.html().replacingOccurrences(of: regionText, with: "")
        let region = Region(id: regionId)
        let name = try athlete.html()
        let id: String?
        if let href = try? athlete.attr("href").replacingOccurrences(of: "/leistungsdatenbank/athletenprofil/", with: ""),
           let index = href.firstIndex(of: "/") {
            id = String(href.prefix(upTo: index))
        } else {
            id = nil
        }
        let performance = try performanceElement.html().nilIfEmpty()
        let attendee = Attendee(id: id, name: name, number: Int(number), yearOfBirth: yearOfBirth)
        return Meldung(performance: performance, rank: nil, region: region ?? Region(id: "UB", name: "Unbekannt"), clubName: clubName, attendees: [attendee])
    }

    private func parseEinzelMeldungOneLADV(athleteRow: Element) throws -> Meldung? {
        guard let athlete = try athleteRow.getElementsByClass("col-12 overflow-hidden text-nowrap").first(),
              let age = try athleteRow.getElementsByTag("small").first(),
              let verein = try athleteRow.getElementsByClass("col-12 overflow-hidden text-nowrap tnsmall").first(),
              let performanceElement = try athleteRow.getElementsByClass("col-12 text-right").first(),
              let number = try athleteRow.getElementsByClass("col-2 text-right").first()?.html()  else {
            return nil
        }
        let ageAndNation = try age.html().split(separator: " ")
        let yearOfBirth: Int = Int(ageAndNation[0])!
        let regionText = try verein.html().suffix(5)
        let regionId = regionText.replacingOccurrences(of: " (", with: "").replacingOccurrences(of: ")", with: "")
        let clubName = try verein.html().replacingOccurrences(of: regionText, with: "")
        let region = Region(id: regionId)
        try athlete.getElementsByTag("small").first()?.remove()
        let name = try athlete.html()
        let performance = try performanceElement.html().nilIfEmpty()
        let attendee = Attendee(id: nil, name: name, number: Int(number), yearOfBirth: yearOfBirth)
        return Meldung(performance: performance, rank: nil, region: region ?? Region(id: "UB", name: "Unbekannt"), clubName: clubName, attendees: [attendee])
    }

    private func parseTeamMeldung(meldungRow: Element) throws -> Meldung? {
        guard let numbers = try meldungRow.getElementsByClass("col-2 text-right").first?.getElementsByClass("tnsmall").map({ try $0.html() }) else {
            return nil
        }
        let athletesElements = try meldungRow.getElementsByClass("row")[1].getElementsByClass("tnsmall")

        var attendees = [Attendee]()
        for (number, athleteRow) in zip(numbers, athletesElements) {
            guard let athlete = try athleteRow.getElementsByTag("a").first(),
                  let age = try athleteRow.getElementsByTag("small").first() else {
                continue
            }
            let ageAndNation = try age.html().split(separator: " ")
            let yearOfBirth: Int = Int(ageAndNation[0])!
            let name = try athlete.html()
            let id: String?
            if let href = try? athlete.attr("href").replacingOccurrences(of: "/leistungsdatenbank/athletenprofil/", with: ""),
               let index = href.firstIndex(of: "/") {
                id = String(href.prefix(upTo: index))
            } else {
                id = nil
            }
            attendees.append(Attendee(id: id, name: name, number: Int(number), yearOfBirth: yearOfBirth))
        }

        let verein = try meldungRow.getElementsByClass("row")[1].getElementsByClass("col-12 overflow-hidden text-nowrap").first()!
        let regionText = try verein.html().suffix(5)
        let regionId = regionText.replacingOccurrences(of: " (", with: "").replacingOccurrences(of: ")", with: "")
        let clubName = try verein.html().replacingOccurrences(of: regionText, with: "")
        let region = Region(id: regionId)


        return Meldung(
            performance: nil,
            rank: nil,
            region: region ?? Region(id: "UB", name: "Unbekannt"),
            clubName: clubName,
            attendees: attendees
        )
    }
    
}

extension String {

    /// Returns `nil` if this string is empty, otherwise the string itself.
    public func nilIfEmpty() -> String? {
        return isEmpty ? nil : self
    }

}

extension SwiftSoup.Element {

    func followingElements() -> [Element] {
        let siblingIndex = self.siblingIndex
        return Array(siblingElements().suffix(from: siblingIndex))
    }

}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
