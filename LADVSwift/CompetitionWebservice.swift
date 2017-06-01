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
extension CompetitionResultDetails: JSONMappable {}

public struct CompetitionWebService {
    public init() {}
    public func searchCompetitions(filter: CompetitionFilter) -> Resource<Array<Competition>> {
        var parameters = filter.toDictionary()
        parameters["mostCurrent"] = true
        parameters["limit"] = 100
        
        let request = NetworkRequest(path: "ausList", baseURLKey: LADV.ladvURLKey,
                                     parameter: parameters)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func competitionDetails(for competitions: [CompetitionDescribing]) -> Resource<[CompetitionDetails]> {
        let ids = competitions.map( { "\($0.id)" } ).joined(separator: ",")
        let parameters: [String: Any] = ["id": ids, "all": true, "wettbewerbe": true]
        let request = NetworkRequest(path: "ausDetail", baseURLKey: LADV.ladvURLKey,
                                     parameter: parameters)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func competitionDetail(for competition: CompetitionDescribing) -> Resource<CompetitionDetails> {
        return competitionDetails(for: [competition]).map(transform: { $0.first! })
    }
    
}


