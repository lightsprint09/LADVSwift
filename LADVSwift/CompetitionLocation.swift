//
//  CompetitionLocation.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 11.02.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import CoreLocation

public struct CompetitionLocation {
    public let id: Int
    public let name: String
    public let lv: String
    public let latitude: Double
    public let longitude: Double
}

extension CompetitionLocation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
