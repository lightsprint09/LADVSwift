//
//  CompetitionFilterTests.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 16.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import XCTest
@testable import LADVSwift

class CompetitionFilterTest: XCTestCase {
    
    func testAgeClasses() {
        //Given
        let ageClass = Age(dlvID: "dlvID")
        var filter = CompetitionFilter()
        filter.ageClasses = [ageClass]
     
        //When
        let dictionary = filter.toDictionary()
        
        //Then
        XCTAssertEqual(dictionary["klasse"], "dlvID")
    }
    
    func testAgeClassesNil() {
        //Given
        let filter = CompetitionFilter()
        
        //When
        let dictionary = filter.toDictionary()
        
        //Then
        XCTAssertNil(dictionary["klasse"])
    }
}
