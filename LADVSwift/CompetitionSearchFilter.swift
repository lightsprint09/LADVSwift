//
//  CompetitionSearchFilter.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 16.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct CompetitionFilter {
    public init() {}
    public var ageClasses: [Age]?
    public var disciplins: [Disciplin]?
    public var regions: [Region]?
    public var categories: [CompetitionCategory]?
}

extension CompetitionFilter {
    func toDictionary() -> [String: String] {
        var parameters = [String: String]()
        parameters["klasse"] = ageClasses?.asQueryParameter{ $0.dlvID }
        parameters["disziplin"] = disciplins?.asQueryParameter{ $0.dlvID }
        parameters["lv"] = regions?.asQueryParameter { $0.id }
        parameters["andTags"] = categories?.asQueryParameter { $0.name }
        
        return parameters
    }
}

fileprivate extension Array {
    func asQueryParameter(_ transform: (Element) -> String) -> String? {
        guard !isEmpty else {
            return nil
        }
        return map(transform).joined(separator: ",")
    }
}
