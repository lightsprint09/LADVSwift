//
//  PerfomaceFormatter.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 27.05.18.
//  Copyright © 2018 freiraum. All rights reserved.
//

import Foundation

public final class PerfomaceFormatter {
    
    public func string(for performance: Performance) -> String {
        let value = performance.value
        switch performance.disciplin.unit {
        case .metrisch:
            return value + "m"
        case .zeit:
            let componetsCount = value.components(separatedBy: ":").count
            if componetsCount == 1 {
                return value + "s"
            }
            if componetsCount == 2 {
                return value + "min"
            }
            if componetsCount == 3 {
                return value + "h"
            }
            return value
        case .punkte:
            return value + "Punkte"
        case .unknown:
            return value
        }
    }
    
//    func validate(string: String, ofUnit unit: Disciplin.Unit) -> Bool {
//        switch unit {
//        case .metrisch:
//            let kommas = string.trimmingCharacters(in: .decimalDigits)
//            return kommas.count == 0 || ( kommas.count == 0 && ",".contains(kommas))
//        case .punkte:
//            let kommas = string.trimmingCharacters(in: .decimalDigits)
//            return kommas.count == 0
//        case .zeit:
//        //04:23:05,05
//            return false
//        default:
//            <#code#>
//        }
//    }
}
