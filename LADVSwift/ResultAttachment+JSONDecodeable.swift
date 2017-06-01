//
//  ResultAttachment+JSONDecodeable.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 01.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import JSONCodable

extension ResultAttachement: JSONCodable {
    public init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        name = try decoder.decode("name")
        let urlString: String = try decoder.decode("url")
        url = URL(string: urlString)!
        fileType = try decoder.decode("type")
        obsolete = try decoder.decode("obsolete")
    }
}
