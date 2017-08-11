//
//  Gender.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 29.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public enum Gender: String {
    case male = "M"
    case female = "F"
    
    init?(string: String) {
        if string == "W" || string == "F" {
            self = .female
        } else if string == "M" {
            self = .male
        } else {
            return nil
        }
    }
}
