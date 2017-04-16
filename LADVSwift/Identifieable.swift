//
//  Identifieable.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 29.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public protocol Identifieable: Hashable {
    var id: Int { get }
}

extension Identifieable {
    public var hashValue: Int {
        return id.hashValue
    }
}

public func ==<T: Identifieable>(lhs: T, rhs: T) -> Bool {
    return lhs.id == rhs.id
}
