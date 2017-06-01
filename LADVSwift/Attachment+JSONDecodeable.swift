//
//  Attachment+JSONDecodeable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 22.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension Attachement: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        name = try decoder.decode("name")
        let urlString: String = try decoder.decode("url")
        url = URL(string: urlString)!
    }
}
