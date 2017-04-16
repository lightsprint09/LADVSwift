//
//  AthletDetails.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct AthletDetails {
    let id: Int
    public let athletnumber: Int
    public let firstname: String
    public let lastname: String
    public let gender: Gender
    public let yearOfBith: Int
    public let vereinNumber: Int
    public let vereinname: String
    public let landesverband: String
    public let competitions: [Competition]
    public let performances: [Performance]
}

public extension AthletDetails{
    func sortedCompetitions() -> ([[Competition]], description: [String]) {
        let sortedCompetitions = competitions.split(sectionSpecificElement: { $0.date < Date() })
        let description = sortedCompetitions.map { ($0.first!.date < Date()) ? "Gestartet" : "Gemeldet" }
        
        return (sortedCompetitions, description)
    }
}

public extension AthletDetails {
    func merged(detail: AthletDetails) -> AthletDetails {
        let newCompetitions = self.competitions + detail.competitions
        let performances = self.performances + detail.performances
        
        return AthletDetails(id: id, athletnumber: athletnumber, firstname: firstname, lastname: lastname, gender: gender, yearOfBith: yearOfBith, vereinNumber: vereinNumber, vereinname: vereinname, landesverband: landesverband, competitions: Array(Set(newCompetitions)).sorted(by: { $0.date > $1.date }), performances: Array(Set(performances)).sorted(by: { $0.date > $1.date }))
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


