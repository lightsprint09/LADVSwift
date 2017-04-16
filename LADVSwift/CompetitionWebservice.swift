//
//  CompetitionWebservice.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 09.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import DBNetworkStack

extension Competition: JSONMappable {}
extension CompetitionDetails: JSONMappable {}

public struct CompetitionFilter {
    public init() {}
    public var ageClasses: [Age]?
    public var disciplins: [Disciplin]?
    public var regions: [Region]?
    public var categories: [CompetitionCategory]?
}

public func SearchCompetitions(filter: CompetitionFilter) -> Resource<Array<Competition>> {
    var parameters: [String: Any] = ["mostCurrent": "true", "limit": 100]
    if let ageClasses = filter.ageClasses, !ageClasses.isEmpty {
        parameters["klasse"] = ageClasses.map( { $0.dlvID } ).joined(separator: ",")
    }
    if let disciplins = filter.disciplins, !disciplins.isEmpty {
        parameters["disziplin"] = disciplins.map( { $0.dlvID } ).joined(separator: ",")
    }
    if let regions = filter.regions, !regions.isEmpty {
        parameters["lv"] = regions.map { $0.id }.joined(separator: ",")
    }
    if let categories = filter.categories, !categories.isEmpty {
        parameters["andTags"] = categories.map { $0.name }.joined(separator: ",")
    }
    let request = NetworkRequest(path: "ausList", baseURLKey: LADVURLConfig.ladvURLKey,
                                 parameter: parameters)
    
    return JSONArrayResource(request: request).wrapped()
}

public func CompetitionDetail(for competition: CompetitionDescribing) -> Resource<CompetitionDetails> {
    let request = NetworkRequest(path: "ausDetail", baseURLKey: LADVURLConfig.ladvURLKey,
                                 parameter: ["id": competition.id, "ort": true, "wettbewerbe": true, "attachements": true, "links": true, "veranstaltungen": true])
    
    return JSONArrayResource<CompetitionDetails>(request: request).map(transform: { $0.first! }).wrapped()
    
}
