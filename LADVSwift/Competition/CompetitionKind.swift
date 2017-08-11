//
//  CompetitionKind.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct CompetitionKind {
    public let age: Age
    public let disciplin: Disciplin
}

public extension CompetitionKind {
    static func sort(competitionKinds: [CompetitionKind]) -> ([[CompetitionKind]], [Age]) {
        let data = competitionKinds.split(sectionSpecificElement: { $0.age.dlvID }).sorted(by: { $0.first!.age.dlvID < $1.first!.age.dlvID })
        let ages = data.map { $0.first!.age }
    
        return (data, ages)
    }
}

