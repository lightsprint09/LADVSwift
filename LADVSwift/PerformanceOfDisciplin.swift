//
//  PerformanceOfDisciplin.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 02.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct PerformancesOfDisciplin {
    public let disciplin: Disciplin
    public let performances: [Performance]
    public var personalBest: Performance? {
        return performances.first(where: { $0.isPersonalBest })
    }
}

public extension PerformancesOfDisciplin {
    var perYearPeromances: ([[Performance]], [String]) {
        let sortedByYear = performances.split(sectionSpecificElement:  { $0.dateText.components(separatedBy: ".").last! }).sorted(by: { $0.0.first!.date > $0.1.first!.date })
        let years = sortedByYear.map({  $0.first!.dateText.components(separatedBy: ".").last! })
        
        return (sortedByYear, years)
    }
}

