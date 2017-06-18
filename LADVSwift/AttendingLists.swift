//
//  AttendingLists.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 09.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import Fuzi

public struct Attendee {
    public let id: String?
    public let name: String
    public let number: Int?
    public let yearOfBirth: Int
}

public struct Meldung {
    public let performance: String?
    public let rank: Int?
    public let region: Region
    public let clubName: String
    public let attendees: [Attendee]
}

public struct AttendingDisciplins {
    public let requiredPerformance: String?
    public let disciplin: Disciplin
    public let attendees: [Meldung]
}

public struct MeldungPerAge {
    public let age: Age
    public let disciplins: [AttendingDisciplins]
}

public struct MeldungParser {
    public init() {}
    
    func extract(atIndex index: Int, inNodes nodes: [XMLElement], ageID: String) -> [AttendingDisciplins] {
        let range = nodes[(index + 1)..<nodes.count]
        let endIndex = range.index(where: { $0.attr("class") == "klasse"}) ?? nodes.count - 1
        var result = [AttendingDisciplins]()
        var attendeeIndex = 0
        for i in index..<endIndex {
            let node = nodes[i]
            if let nodeClass = node.attr("class"), nodeClass == "disziplin" {
                
                let id = node.children[0].attr("id")!
                let ageRange = id.range(of: ageID)!
                let ladvId = id.replacingCharacters(in: ageRange, with: "")
                let disciplin = Disciplin(ladvId: ladvId)
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
    
    func extractRequiredPerformance(node: XMLElement) -> String? {
        if node.stringValue.contains("Mindestleistung") {
            let stringValue = node.stringValue
            let range = stringValue.range(of: "Mindestleistung: ")!
            let range2 = Range(uncheckedBounds: (range.upperBound, stringValue.endIndex))
            let endRange = node.stringValue.range(of: ")", options: [], range: range2, locale: nil)
            
            return stringValue.substring(with: Range(uncheckedBounds: (range.upperBound, endRange!.lowerBound)))
        }
        return nil
    }
    
    func extract(atIndex index: Int, inNodes nodes: [XMLElement]) -> [Meldung] {
        if index + 2 >= nodes.count {
            return []
        }
        let node = nodes[index + 2]
        var result = [Meldung]()
        if let nodeClass = node.attr("class"), nodeClass == "teinzel" {
            if node.children[0].children[0].children[4].stringValue.characters.count < 2 {
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
    
    func extractStaffel(node: XMLElement) -> [Meldung] {
        let nodes = node.children[0].children
        let teams = nodes.filter { $0.attr("class") == "odd" }
        return teams.map { teamNode in
            let club = teamNode.children[1].stringValue
            let rank = Int(teamNode.children[2].stringValue.replacingOccurrences(of: "#", with: ""))
            let region = Region(id: teamNode.children[3].stringValue)
            let performance = teamNode.children[5].stringValue
            
            var athletes = [Attendee]()
            let index = nodes.index(where: { $0.stringValue == teamNode.stringValue })! + 1
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
    
    func extractAttendee(from attributes: [XMLElement]) -> Attendee {
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
        
        return newHref.substring(to: index.lowerBound)
    }
    
    public func parse(html: Data) throws -> [MeldungPerAge] {
        let document = try HTMLDocument(data: html)
        return parse(document: document)
    }
    
    public func parse(html: String) throws -> [MeldungPerAge] {
        let document = try HTMLDocument(string: html, encoding: .utf8)
        return parse(document: document)
    }
        
    func parse(document: HTMLDocument) -> [MeldungPerAge] {
        let elemets = document.firstChild(xpath: "//div[@class='body']")?.children[1]
        var result = [MeldungPerAge]()
        
        for (i, element) in elemets!.children.enumerated() {
            if let ageElement = element.attr("class"), ageElement == "klasse" {
                let id = element.children[0].attr("id")
                let age = Age(any: id!)
                result.append(MeldungPerAge(age: age, disciplins: extract(atIndex: i, inNodes: elemets!.children, ageID: id!)))
            }
            
        }
        return result
    }
    
}
