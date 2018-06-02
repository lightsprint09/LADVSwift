//
//  CompetitionWebservice.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 09.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import DBNetworkStack

public struct CompetitionWebService {
    
    private let baseURL: URL
    private let jsonDecoder: JSONDecoder
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.millisecondsSince1970
    }
    
    public func searchCompetitions(filter: CompetitionFilter) -> Resource<[Ausschreibung]> {
        var parameters = filter.toDictionary()
        parameters["mostCurrent"] = "\(true)"
        parameters["limit"] = "\(100)"
        
        let request = URLRequest(path: "ausList", baseURL: baseURL, parameters: parameters)
        
        return Resource(request: request, decoder: jsonDecoder)
    }
    
    public func competitionDetails(for competitionIds: [Int]) -> Resource<[CompetitionDetails]> {
        let ids = competitionIds.map( { "\($0)" } ).joined(separator: ",")
        let parameters = ["id": "\(ids)", "all": "\(true)", "wettbewerbe": "\(true)"]
        let request = URLRequest(path: "ausDetail", baseURL: baseURL, parameters: parameters)
        
        return Resource(request: request, parse: { data in
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [Any]
            
            return try Array(JSONArray: json)
        })
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
        return competitionDetails(for: competitions.map { $0.id } )
    }
    
    public func competitionDetail(for competition: CompetitionDescribing) -> Resource<CompetitionDetails> {
        return competitionDetails(for: [competition.id]).map { $0.first! }
    }
}

