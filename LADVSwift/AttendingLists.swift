//
//  AttendingLists.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 09.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

struct MinimalAthlete: AthleteDescribing {
    let ladvId: Int
    let firstname: String
    let lastname: String
    let yearOfBirth: Int
    
}

public struct Attendee {
    public let id: String?
    public let name: String
    public let number: Int?
    public let yearOfBirth: Int
}

extension Attendee {
    public func toAthlete() -> AthleteDescribing? {
        let splittedName = name.components(separatedBy: " ")
        guard let id = id, let ladvId = Int(id), splittedName.count > 1 else {
            return nil
        }
        return MinimalAthlete(ladvId: ladvId, firstname: splittedName[0], lastname: splittedName[1], yearOfBirth: yearOfBirth)
    }
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
