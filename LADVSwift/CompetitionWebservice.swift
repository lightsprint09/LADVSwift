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
    let baseURL: URL
    
    public init(APIKey: String) {
        self.baseURL = URL(string: "http://ladv.de/api/\(APIKey)/")!
    }
    
    public func searchCompetitions(filter: CompetitionFilter) -> Resource<Array<Competition>> {
        var parameters = filter.toDictionary()
        parameters["mostCurrent"] = true
        parameters["limit"] = 100
        
        let request = URLRequest(path: "ausList", baseURL: baseURL, parameters: parameters)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func competitionDetails(for competitionIds: [Int]) -> Resource<[CompetitionDetails]> {
        let ids = competitionIds.map( { "\($0)" } ).joined(separator: ",")
        let parameters: [String: Any] = ["id": ids, "all": true, "wettbewerbe": true]
        let request = URLRequest(path: "ausDetail", baseURL: baseURL, parameters: parameters)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func competitionDetail(for competitionId: Int) -> Resource<CompetitionDetails> {
        return competitionDetails(for: [competitionId]).map(transform: { $0.first! })
    }
    
    public func meldungen(for competitionId: Int) -> Resource<[MeldungPerAge]> {
        let request = URLRequest(path: "/meldung/teilnehmer/\(competitionId)", baseURL: baseURL)
        let parser = MeldungParser()
        
        return Resource(request: request, parse: { try parser.parse(html: $0) })
    }
}

extension CompetitionWebService {
    
    public func competitionDetails(for competitions: [CompetitionDescribing]) -> Resource<[CompetitionDetails]> {
        return competitionDetails(for: competitions.map({ $0.id }))
    }
    
    public func competitionDetail(for competition: CompetitionDescribing) -> Resource<CompetitionDetails> {
        return competitionDetails(for: [competition.id]).map(transform: { $0.first! })
    }
}

