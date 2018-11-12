//
//  request.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

public class OutgoingMessage: Codable {
    let type : String
    var requestID : String!
    var fetch : Bool = false
    var listen : Bool = false
    
    enum CodingKeys: String, CodingKey {
        case type, fetch, listen
        case requestID = "req_id"
    }

    init(withType type: String) {
        self.type = type
    }
}
