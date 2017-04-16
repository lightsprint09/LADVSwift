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
}

public struct LADVURLConfig {
    public init() {}
    
    static let ladvURLKey = "ladvURLKey"
    var baseURL: URL {
        return URL(string: "http://ladv.de/api/\(LADV.APIKey)/")!
    }
    
    public var urlConfiguration: [String: URL] {
        return [LADVURLConfig.ladvURLKey: baseURL]
    }
}

extension Athlete: JSONMappable {}
extension AthletDetails: JSONMappable {}

public struct AthleteWebService {
    public init() {}
    
    public func searchAthlets(with name: String) -> Resource<[Athlete]> {
        let request = NetworkRequest(path: "athletQuery", baseURLKey: LADVURLConfig.ladvURLKey,
                                     parameter: ["query": "*\(name)*"])
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func athletDeatils(for athlets: [AthleteDescribing], datayear: Int) -> Resource<[AthletDetails]> {
        let ids = athlets.map({ "\($0.ladvId)" }).joined(separator: ",")
        let request = NetworkRequest(path: "athletDetail", baseURLKey: LADVURLConfig.ladvURLKey,
                                     parameter: ["id": ids, "all": "true", "datayear": datayear])
        
        return JSONArrayResource(request: request).wrapped()
    }
    
    public func athletDeatils(for athlet: AthleteDescribing, datayear: Int) -> Resource<AthletDetails?> {
        return athletDeatils(for: [athlet], datayear: datayear).map(transform: { $0.first })
    }
}
