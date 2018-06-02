//
//  Leistung.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

fileprivate let performanceDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    
    return formatter
}()

public struct Performance: Hashable {    
    public let location: String
    public let disciplin: Disciplin
    public let value: String
    public let dateText: String
    public let isPersonalBest: Bool
    public let indoor: Bool
    public let wind: String?
    
    public var compareableValue: Double? {
        if let double = Double(value) {
            return double
        }
        let components = value.components(separatedBy: ":")
        let componetsCount = components.count
        
        if let d1 = Double(components[0]), let d2 = Double(components[1]), componetsCount == 2 {
            return d1 * 60 + d2
        }
        if let d1 = Double(components[0]), let d2 = Double(components[1]), let d3 = Double(components[2]), componetsCount == 3 {
            return 3600 * 60 * d1 + 60 * d2 + d3
        }
        return nil
    }
}

extension Performance {
    public var date: Date {
        return performanceDateFormatter.date(from: dateText)!
    }
}
