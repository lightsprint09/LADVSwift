//
//  AtheleteRequests.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import DBNetworkStack

public struct AthleteWebService {
    
    private let baseURL: URL
    
    public init(baseURL: URL) {
       self.baseURL = baseURL
    }
    
    public func searchAthlets(with name: String, `in` region: Region? = nil, forYear year: Int? = nil) -> Resource<[Athlete]> {
        var parameter =  ["query": "*\(name)*"]
        parameter["lv"] = region?.id
        parameter["datayear"] = year.map { "\($0)" }

        let request = URLRequest(path: "athletQuery", baseURL: baseURL, parameters: parameter)
        
        return Resource(request: request, parse: { data in
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let array = json as! [Any]
            
            return try Array(JSONArray: array)
        })
    }
    
    public func athletDeatils(for athlets: [AthleteDescribing], year: Int) -> Resource<[AthletDetails]> {
        let ids = athlets.map { $0.id }
        return athletDeatils(for: ids, year: year)
    }
    
    public func athletDeatils(for athlet: AthleteDescribing, year: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athlet], year: year).map(transform: { $0.first })
    }
    
    public func athletDeatils(for athletIds: [Int], year: Int) -> Resource<[AthletDetails]> {
        let ids = athletIds.map({ "\($0)" }).joined(separator: ",")
        let parameter = ["id": ids, "all": "true", "datayear": "\(year)"]
        let request = URLRequest(path: "athletDetail", baseURL: baseURL, parameters: parameter)
        
        return Resource(request: request, parse: { data in
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [Any]
            
            return try Array(JSONArray: json)
        })
    }
    
    public func athletDeatils(for athletId: Int, year: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athletId], year: year).map(transform: { $0.first })
    }
}
