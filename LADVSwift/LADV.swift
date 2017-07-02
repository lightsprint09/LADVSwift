//
//  LADV.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 25.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct LADV {
    public static var APIKey: String = ""
    
    static let ladvURLKey = "ladvURLKey"
    static let ladvWebPageURLKey = "ladvWebPageURLKey"
    static var baseURL: URL {
        return URL(string: "http://ladv.de/api/\(LADV.APIKey)/")!
    }
    static var webPagebaseURL: URL {
        return URL(string: "https://ladv.de/")!
    }
    
    public static var urlConfiguration: [String: URL] {
        return [ladvURLKey: baseURL, ladvWebPageURLKey: webPagebaseURL]
    }
}
