//
//  AuschreibungParseTest.swift
//  LADVSwiftTests
//
//  Created by Lukas Schmidt on 27.05.18.
//  Copyright © 2018 freiraum. All rights reserved.
//

import XCTest
import LADVSwift

class AuschreibungParseTest: XCTestCase {
    
    func testsearchCompetitions() {
        //Given
        let webservice = CompetitionWebService(baseURL: URL(string: "ladv.de")!)
        let filter = CompetitionFilter()
        let resource = webservice.searchCompetitions(filter: filter)
        let path = Bundle(for: AuschreibungParseTest.self).url(forResource: "AusList", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        
        //When
        let ausschreibungen = try! resource.parse(data)
        
        //Then
        XCTAssertEqual(ausschreibungen.first?.id, 1)
        XCTAssertEqual(ausschreibungen.first?.date, Date(timeIntervalSince1970: 1279058400))
        XCTAssertEqual(ausschreibungen.first?.meldeSchlussDate, Date(timeIntervalSince1970: 1278712800))
    }
    
    
}
