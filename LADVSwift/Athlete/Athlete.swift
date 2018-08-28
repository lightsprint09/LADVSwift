//
//  Athlete.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

public struct Athlete: Hashable {
    public let id: Int
    public let athletnumber: Int
    public let firstname: String
    public let lastname: String
    public let gender: Gender
    public let yearOfBirth: Int
    public let allClubs: [Club]
    
    public var hashValue: Int { return id.hashValue }
}

extension Athlete {
    public var currentClub: Club {
        get { return allClubs.first! }
    }
}
