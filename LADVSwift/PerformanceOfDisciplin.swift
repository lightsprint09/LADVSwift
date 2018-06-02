//
//  PerformanceOfDisciplin.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 02.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

// TODO: Remove with swift 4.2
extension Array: Hashable where Element: Hashable {
    public var hashValue: Int {
        return 0
    }
}
// TODO: Remove with swift 4.2
extension Optional: Hashable where Wrapped: Hashable {
    public var hashValue: Int {
        return 0
    }
}
import Foundation

public struct PerformancesOfDisciplin: Hashable {
    public let disciplin: Disciplin
    public let performances: [Performance]
    public var personalBest: Performance? {
        return performances.first(where: { $0.isPersonalBest })
    }
}

public extension PerformancesOfDisciplin {
    var perYearPerformances: ([[Performance]], [String]) {
        let sortedByYear = performances.split(sectionSpecificElement:  { $0.dateText.components(separatedBy: ".").last! }).sorted(by: { $0.first!.date > $1.first!.date })
        let years = sortedByYear.map({  $0.first!.dateText.components(separatedBy: ".").last! })
        
        return (sortedByYear, years)
    }
}

