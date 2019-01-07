//
//  eoswsTests.swift
//  eoswsTests
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import XCTest
@testable import eosws

class eoswsTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testExample() {
        let expectation = self.expectation(description: #function)
        
        let token = "eyJhbGciOiJLTVNFUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NTIxMDkyMjAsImp0aSI6Ijc1NWViYmI4LTZhMTktNDBjZi1hMjlhLTU3MTY4MjRjOTM3ZSIsImlhdCI6MTU0NDEwOTIyMCwiaXNzIjoiZGZ1c2UuaW8iLCJzdWIiOiJDaVFBNmNieWU4WkZaWFIrVmJ3YkVVbFNsa0pHQXExTHFHWlZSUzh5ZFhwVmplOFIyVzRTT1FBL0NMUnRFU1hrS05vdzJsS3ZSR3NHQ1NTMnlHRmJidFRlY3lhOE54V3c4aksvUVdWYXMwNGJJbU5GY2IvNVI1VnRRNUdXeGIxd2NBPT0iLCJ0aWVyIjoiYmV0YS12MSIsInN0YmxrIjoxLCJ2IjoxfQ._VoD77DeMGqPb0FQWzEieP5wsF7fhP3hUYo0qxoW5U7MXDS9sG8hai_FGXUE81gGj1ofW97-6z1blVvQHs29YQ"
        let eosws = try? EOSWS(forEnpoint: "wss://staging-kylin.eos.dfuse.io/v1/stream", token: token, origin: "origin.example.com")
        
        waitForExpectations(timeout: 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
