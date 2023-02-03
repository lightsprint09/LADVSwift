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

    /*
    func extract(atIndex index: Int, inNodes nodes: [Fuzi.XMLElement], ageID: String) -> [AttendingDisciplins] {
        let range = nodes[(index + 1)..<nodes.count]
        let endIndex = range.firstIndex(where: { $0.attr("class") == "klasse"}) ?? nodes.count - 1
        var result = [AttendingDisciplins]()
        var attendeeIndex = 0
        for i in index..<endIndex {
            let node = nodes[i]
            if let nodeClass = node.attr("class"), nodeClass == "disziplin" {
                
                let id = node.attr("id") ?? node.children[0].attr("id")!
                let ageRange = id.range(of: ageID)!
                let code = id.replacingCharacters(in: ageRange, with: "")
                let disciplin = Disciplin(code: code)
                let attendees = extract(atIndex: index + attendeeIndex, inNodes: nodes)
                result.append(AttendingDisciplins(requiredPerformance: extractRequiredPerformance(node: node), disciplin: disciplin, attendees: attendees))
                if attendees.isEmpty {
                    attendeeIndex += 1
                } else {
                    attendeeIndex += 2
                }
            }
        }
        return result
    }
    
    func extractRequiredPerformance(node: Fuzi.XMLElement) -> String? {
        if node.stringValue.contains("Mindestleistung") {
            let stringValue = node.stringValue
            let range = stringValue.range(of: "Mindestleistung: ")!
            let range2 = Range(uncheckedBounds: (range.upperBound, stringValue.endIndex))
            
            let endRange: Range<String.Index>!
            if let end = node.stringValue.range(of: ";", options: [], range: range2, locale: nil) {
                endRange = end
            } else {
                endRange = node.stringValue.range(of: ")", options: [], range: range2, locale: nil)
            }
            
            return stringValue.substring(with: Range(uncheckedBounds: (range.upperBound, endRange.lowerBound)))
        }
        return nil
    }
    
    func extract(atIndex index: Int, inNodes nodes: [Fuzi.XMLElement]) -> [Meldung] {
        if index + 2 >= nodes.count {
            return []
        }
        let node = nodes[index + 2]
        var result = [Meldung]()
        if let nodeClass = node.attr("class"), nodeClass == "teinzel" {
            if node.children[0].children[0].children[4].stringValue.count < 2 {
                return extractStaffel(node: node)
            }
            for meldungNode in node.children[0].children {
                let attributes = meldungNode.children
                let regionId = attributes[3].stringValue
                let club = attributes[4].stringValue
                let region = Region(id: regionId) ?? Region(id: regionId, name: club)
                let performance = attributes[5].stringValue
                
                let attendee = extractAttendee(from: attributes)
                result.append(Meldung(performance: performance, rank: nil, region: region, clubName: club, attendees: [attendee]))
            }
        }
        return result
    }
    
    func extractStaffel(node: Fuzi.XMLElement) -> [Meldung] {
        let nodes = node.children[0].children
        let teams = nodes.filter { $0.attr("class") == "odd" }
        return teams.map { teamNode in
            let club = teamNode.children[1].stringValue
            let rank = Int(teamNode.children[2].stringValue.replacingOccurrences(of: "#", with: ""))
            let region = Region(id: teamNode.children[3].stringValue)
            let performance = teamNode.children[5].stringValue
            
            var athletes = [Attendee]()
            let index = nodes.firstIndex(where: { $0.stringValue == teamNode.stringValue })! + 1
            if !(index > nodes.count - 1) {
                for i in index..<nodes.count - 1 {
                    if nodes[i].attr("class") == "odd" {
                        break
                    }
                    let attributes = nodes[i].children
                    let attendee = extractAttendee(from: attributes)
                    athletes.append(attendee)
                }
            }
            
            
            return Meldung(performance: performance, rank: rank, region: region!, clubName: club, attendees: athletes)
        }
    }
    
    func extractAttendee(from attributes: [Fuzi.XMLElement]) -> Attendee {
        let number = Int(attributes[0].stringValue)
        let nameLink = attributes[1].children.isEmpty ? nil : attributes[1].children[0]
        let name = nameLink?.stringValue ?? attributes[1].stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        let yearOfBirth = Int(attributes[2].stringValue)
        let id = nameLink.map { extractAttendeeId(href: $0.attr("href")!)}
        
        return Attendee(id: id, name: name, number: number, yearOfBirth: yearOfBirth!)
    }
    
    func extractAttendeeId(href: String) -> String {
        let newHref = href.replacingOccurrences(of: "/leistungsdatenbank/athletenprofil/", with: "")
        let index = newHref.range(of: "/")!
        
        let range = PartialRangeUpTo(index.lowerBound)
        return String(newHref[range])
    }*/
    
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


        for age in Age.all {
            guard let ageHeadline = try document.getElementById(age.ladvID) else {
                continue
            }
            var disciplins = [AttendingDisciplins]()
            for disciplinAnchor in ageHeadline.siblingElements().filter({ $0.hasClass("anchor") && (try? $0.attr("id")) != age.dlvID && ((try? $0.attr("id")) ?? "").contains( age.dlvID) }) {
                let dlvID = try disciplinAnchor.attr("id")
                let disciplin = Disciplin(dlvID: dlvID.replacingOccurrences(of: age.ladvID, with: ""))
                var meldungen: [Meldung] = []
                let index = ageHeadline.siblingElements().firstIndex(of: disciplinAnchor)
                let rows = Array(disciplinAnchor.siblingElements().suffix(from: index! + 2))
                let end = try rows.firstIndex(where: { try $0.className() != "row" })
                for row in rows.prefix(upTo: end ?? rows.count - 1) {
                    guard let athlete = try row.getElementsByTag("a").first(),
                          let age = try row.getElementsByTag("small").first(),
                          let verein = try row.getElementsByClass("col-12 overflow-hidden text-nowrap tnsmall").first(),
                          let performanceElement = try row.getElementsByClass("col-12 text-right").first(),
                          let number = try row.getElementsByClass("col-2 text-right").first()?.html()  else {
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
