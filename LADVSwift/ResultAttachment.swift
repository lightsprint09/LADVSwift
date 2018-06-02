//
//  ResultAttachment.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 01.06.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct ResultAttachement: Hashable {
    public let name: String
    public let url: URL
    public let fileType: String
    public let obsolete: Bool
}
