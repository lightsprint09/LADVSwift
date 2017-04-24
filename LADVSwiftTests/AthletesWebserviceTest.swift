//
//  AthletsWebserviceTest.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 17.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import XCTest
@testable import LADVSwift

class AthletesWebserviceTest: XCTestCase {
    let webservice = AthleteWebService()
    
    func testSearchAthletesWithCorrectParameters() {
        //Given
        let searchString = "Test"
        let region = Region(id: "Test", name: "")
        
        //When
        let resource = webservice.searchAthlets(with: searchString, in: region)
        
        //Then
        XCTAssertEqual(resource.request.parameter?["query"] as? String, "*Test*")
        XCTAssertEqual(resource.request.parameter?["lv"] as? String, "Test")
    }
    
    func testParseResponse() {
//        let json = try? String(contentsOfFile: "SearchAthletes.json")
//        print(json)
    }
}
