//
//  Athlete.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 28.01.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public struct Athlete {
    public let ladvId: Int
    public let athletnumber: Int
    public let firstname: String
    public let lastname: String
    public let gender: Gender
    public let yearOfBirth: Int
    public let vereinNumber: Int
    public let vereinname: String
    public let landesverband: String
}

extension Athlete: Identifieable {
    public var id: Int { return ladvId }
}
