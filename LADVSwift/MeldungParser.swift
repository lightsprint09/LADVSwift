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
        let document: Document = try SwiftSoup.parse(string)
        return try parse(document: document)
    }
    
    public func parse(html: String) throws -> [MeldungPerAge] {
        let document: Document = try SwiftSoup.parse(html)
        return try parse(document: document)
    }

    func parse(document: Document) throws -> [MeldungPerAge] {
        var result = [MeldungPerAge]()
        let disciplinDlvIDs = Set(Disciplin.all.map { $0.code })

        for age in Age.all {
            guard let ageHeadline = try document.getElementById(age.ladvID) else {
                continue
            }
            var disciplins = [AttendingDisciplins]()

            let disciplinAnchors = try document.getElementsByClass("anchor").filter({
                guard let id = try? $0.attr("id"), id != age.dlvID, $0.hasClass("anchor"), id.contains(age.dlvID) else {
                    return false
                }
                let diciplin = id.replacingOccurrences(of: age.dlvID, with: "")
                return disciplinDlvIDs.contains(diciplin)
            })

            for disciplinAnchor in disciplinAnchors {
                let dlvID = try disciplinAnchor.attr("id")
                let disciplin = Disciplin(dlvID: dlvID.replacingOccurrences(of: age.ladvID, with: ""))
                var meldungen: [Meldung] = []

                let index = ageHeadline.siblingElements().firstIndex(of: disciplinAnchor)
                let rows = Array(disciplinAnchor.siblingElements().suffix(from: index!))
                guard let row = try rows.first(where: { try $0.className() == "row" }) else {
                    continue
                }
                for athleteRow in try row.getElementsByClass("einzel block ") {
                    guard let athlete = try athleteRow.getElementsByTag("a").first(),
                          let age = try athleteRow.getElementsByTag("small").first(),
                          let verein = try athleteRow.getElementsByClass("col-12 overflow-hidden text-nowrap tnsmall").first(),
                          let performanceElement = try athleteRow.getElementsByClass("col-12 text-right").first(),
                          let number = try athleteRow.getElementsByClass("col-2 text-right").first()?.html()  else {
                        continue
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
                    let meldung = Meldung(performance: performance, rank: nil, region: region ?? Region(id: "UB", name: "Unbekannt"), clubName: clubName, attendees: [attendee])
                    meldungen.append(meldung)

                }
                disciplins.append(AttendingDisciplins(requiredPerformance: nil, disciplin: disciplin, attendees: meldungen))
            }

            result.append(MeldungPerAge(
                age: age,
                disciplins: disciplins
            ))
            /*
            let zipped = zip(document.xpath("[@id='\(id)']/following-sibling::div//a"), document.xpath("[@id='\(id)']/following-sibling::div//a/following-sibling::small"))

            for (athlete, age) in zipped {
                let ageAndNation = age.stringValue.split(separator: " ")
                let yearOfBirth: Int = Int(ageAndNation[0])!
                let clubName = "clubName"
                let region = Region.all.first!
                let name = athlete.stringValue
                let id: String?
                if let href = athlete.attributes["href"]?.replacingOccurrences(of: "/leistungsdatenbank/athletenprofil/", with: ""),
                   let index = href.firstIndex(of: "/") {
                    id = String(href.prefix(upTo: index))
                } else {
                    id = nil
                }
                let attendee = Attendee(id: id, name: name, number: nil, yearOfBirth: yearOfBirth)
                let meldung = Meldung(performance: nil, rank: nil, region: region, clubName: clubName, attendees: [attendee])
                meldungen.append(meldung)
            }
            result.append(MeldungPerAge(
                age: age,
                disciplins: [
                    AttendingDisciplins(requiredPerformance: nil, disciplin: disciplin, attendees: meldungen)
                ])
            )
                                                                                                             */
        }
        return result
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
