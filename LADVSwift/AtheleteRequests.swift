//
//  AtheleteRequests.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import DBNetworkStack

public struct LADV {
    static var APIKey: String = ""
    
    static let ladvURLKey = "ladvURLKey"
    static var baseURL: URL {
        return URL(string: "http://ladv.de/api/\(LADV.APIKey)/")!
    }
    
    public static var urlConfiguration: [String: URL] {
        return [ladvURLKey: baseURL]
    }
}

extension Athlete: JSONMappable {}
extension AthletDetails: JSONMappable {}

public struct AthleteWebService {
    public init() {}
    
    public func searchAthlets(with name: String, `in` region: Region? = nil) -> Resource<[Athlete]> {
        var parameter: [String: Any] =  ["query": "*\(name)*"]
        parameter["lv"] = region?.id
        let request = NetworkRequest(path: "athletQuery", baseURLKey: LADV.ladvURLKey,
                                     parameter: parameter)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func athletDeatils(for athlets: [AthleteDescribing], datayear: Int) -> Resource<[AthletDetails]> {
        let ids = athlets.map({ "\($0.ladvId)" }).joined(separator: ",")
        let parameter: [String: Any] = ["id": ids, "all": "true", "datayear": datayear]
        let request = NetworkRequest(path: "athletDetail", baseURLKey: LADV.ladvURLKey,
                                     parameter: parameter)
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func athletDeatils(for athlet: AthleteDescribing, datayear: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athlet], datayear: datayear).map(transform: { $0.first })
    }
}
