//
//  AthletDetails.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct AthletDetails {
    public let id: Int
    public let athletnumber: Int
    public let firstname: String
    public let lastname: String
    public let gender: Gender
    public let yearOfBirth: Int
    public let allClubs: [Club]
    public let competitions: [Ausschreibung]
    public let performances: [Performance]
}

extension AthletDetails {
    public var currentClub: Club {
        get { return allClubs.first! }
    }
}

extension AthletDetails: AthleteDescribing { }

public extension AthletDetails{
    func sortedCompetitions() -> ([[Ausschreibung]], description: [String]) {
        let sortedCompetitions = competitions.split(sectionSpecificElement: { $0.date < Date() })
        let description = sortedCompetitions.map { ($0.first!.date < Date()) ? "Gestartet" : "Gemeldet" }
        
        return (sortedCompetitions, description)
    }
}

public extension AthletDetails {
    func merged(detail: AthletDetails) -> AthletDetails {
        let newCompetitions = self.competitions + detail.competitions
        let performances = self.performances + detail.performances
        let clubs = self.allClubs + detail.allClubs
        
        return AthletDetails(id: id, athletnumber: athletnumber, firstname: firstname, lastname: lastname, gender: gender, yearOfBirth: yearOfBirth, allClubs: clubs, competitions: Array(Set(newCompetitions)).sorted(by: { $0.date > $1.date }), performances: Array(Set(performances)).sorted(by: { $0.date > $1.date }))
    }
}

public extension AthletDetails {
    var performancesOfDisciplin: [PerformancesOfDisciplin] {
        var dict =  [Disciplin: [Performance]]()
        performances.forEach { performance in
            let diciplin = performance.disciplin
            var array = dict[diciplin] ?? []
            array.append(performance)
            dict[diciplin] = array
        }
        return dict.map { PerformancesOfDisciplin(disciplin: $0, performances: $1) }
    }
}


