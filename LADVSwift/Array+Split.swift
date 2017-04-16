//
//  Array+Split.swift
//  Leichatletik
//
//  Created by Lukas Schmidt on 24.03.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation

public extension Array {
    func split(sectionSpecificElement: (Element) -> AnyHashable) -> [[Element]] {
        var dict =  [AnyHashable: [Element]]()
        forEach { element in
            let hash = sectionSpecificElement(element)
            var array = dict[hash] ?? []
            array.append(element)
            dict[hash] = array
        }
        
        return Array<Array<Element>>(dict.values)
    }
}
