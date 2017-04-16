//
//  Attachement.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 15.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct Attachement {
    public let name: String
    public let url: URL
}

extension Attachement: Identifieable {
    public var id: Int {
        return url.absoluteString.hashValue
    }
}
