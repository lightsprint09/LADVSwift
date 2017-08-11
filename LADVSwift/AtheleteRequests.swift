//
//  AtheleteRequests.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import DBNetworkStack
import JSONCodable

extension Athlete: JSONMappable {}
extension AthletDetails: JSONMappable {}

public struct AthleteWebService {
    
    let baseURL: URL
    
    public init(APIKey: String) {
       self.baseURL = URL(string: "http://ladv.de/api/\(APIKey)/")!
    }
    
    public func searchAthlets(with name: String, `in` region: Region? = nil) -> Resource<[Athlete]> {
        var parameter =  ["query": "*\(name)*"]
        parameter["lv"] = region?.id

        let request = URLRequest(path: "athletQuery", baseURL: baseURL, parameters: parameter)
        
        return Resource(resource: JSONArrayResource(request: request))
    }
    
    public func athletDeatils(for athlets: [AthleteDescribing], datayear: Int) -> Resource<[AthletDetails]> {
        let ids = athlets.map({ "\($0.id)" }).joined(separator: ",")
        let parameter = ["id": ids, "all": "true", "datayear": "\(datayear)"]
        let request = URLRequest(path: "athletDetail", baseURL: baseURL, parameters: parameter)
        
        return Resource(resource: JSONArrayResource(request: request))
    }
    
    public func athletDeatils(for athlet: AthleteDescribing, datayear: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athlet], datayear: datayear).map(transform: { $0.first })
    }
}
