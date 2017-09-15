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


        let request = URLRequest(path: "athletQuery?query:*\(name)*", baseURL: baseURL)
        
        return Resource(resource: JSONArrayResource(request: request))
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
        
        return Resource(resource: JSONArrayResource(request: request))
    }
    
    public func athletDeatils(for athletId: Int, year: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athletId], year: year).map(transform: { $0.first })
    }
}
