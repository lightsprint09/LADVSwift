//
//  AthletsWebserviceTest.swift
//  LADVSwift
//
//  Created by Lukas Schmidt on 17.04.17.
//  Copyright © 2017 freiraum. All rights reserved.
//

import Foundation
import XCTest
import DBNetworkStack
@testable import LADVSwift

extension URL {
    static let mocked = URL(string: "https:ladv.de")!
}

extension Resource {
    func contains(queryItem: URLQueryItem) -> Bool {
        guard let url = request.asURLRequest().url, let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return false
        }
        
        return urlComponents.queryItems?.contains(queryItem) ?? false
    }
}


class AthletesWebserviceTest: XCTestCase {
    let webservice = AthleteWebService(baseURL: .mocked)
    
    func testSearchAthletesWithCorrectParameters() {
        //Given
        let searchString = "Test"
        let region = Region(id: "Test", name: "")
        
        //When
        let resource = webservice.searchAthlets(with: searchString, in: region)
        
        //Then
        XCTAssert(resource.contains(queryItem: URLQueryItem(name: "query", value: "*Test*")))
        XCTAssert(resource.contains(queryItem: URLQueryItem(name: "lv", value: "Test")))
    }
    
    func testParseResponse() {
        let string = """
[{"forename":"Lukas","surname":"Scholtysek","birthyear":1998,"sex":"M","vereinnumber":1102,"lv":"NI","vereinname":"MTV Braunschweig","athletnumber":39686,"id":115786},{"forename":"Lukas","surname":"Schwechheimer","birthyear":2000,"sex":"M","vereinnumber":2211,"lv":"NI","vereinname":"VfL Wolfsburg","athletnumber":41164,"id":140709},{"forename":"Lukas","surname":"Schendel","birthyear":2002,"sex":"M","vereinnumber":3430,"lv":"NI","vereinname":"TK zu Hannover","athletnumber":44857,"id":308444},{"forename":"Lukas","surname":"Schülting","birthyear":1995,"sex":"M","vereinnumber":7722,"lv":"NI","vereinname":"VfL Lingen","athletnumber":45944,"id":333240},{"forename":"Lukas","surname":"Schröder","birthyear":1995,"sex":"M","vereinnumber":4516,"lv":"NI","vereinname":"TV Jahn Schneverdingen","athletnumber":615027,"id":216745},{"forename":"Lukas","surname":"Schewemann","birthyear":2002,"sex":"M","vereinnumber":3246,"lv":"NI","vereinname":"LG Weserbergland","athletnumber":615527,"id":217984},{"forename":"Lukas","surname":"Schendel","birthyear":2002,"sex":"M","vereinnumber":3317,"lv":"NI","vereinname":"TSV Egestorf","athletnumber":607055,"id":176698},{"forename":"Lukas","surname":"Schwier","birthyear":2004,"sex":"M","vereinnumber":3847,"lv":"NI","vereinname":"VfL Bückeburg","athletnumber":600800,"id":108768},{"forename":"Finn-Lukas","surname":"Schwanbeck","birthyear":2006,"sex":"M","vereinnumber":1114,"lv":"NI","vereinname":"SV Grün-Weiß Waggum","athletnumber":600954,"id":110709},{"forename":"Lukas","surname":"Schmidtchen","birthyear":2004,"sex":"M","vereinnumber":7712,"lv":"NI","vereinname":"SV DJK Geeste","athletnumber":610333,"id":179976}]
"""
        let t = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let data = t.data(using: .utf8)
        
        let resource = webservice.searchAthlets(with: "Lukas")
        
        do {
            let athletes = try resource.parse(data!)
            XCTAssertEqual(athletes.count, 10)
        }
        catch let e {
            XCTFail()
        }
    }
}
