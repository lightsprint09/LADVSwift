//
//  AthleteDescribing.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 29.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public protocol AthleteDescribing {
    var ladvId: Int { get }
    var firstname: String { get }
    var lastname: String { get }
    var yearOfBirth: Int { get }
}

public extension AthleteDescribing{
    public var fullName: String {
        return "\(firstname) \(lastname)"
    }
}
