//
//  Response.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct IncomingMessage: Decodable {
    let type : String
    var requestID : String?
    var data: Any?

    enum CodingKeys: String, CodingKey {
        case type, data
        case requestID = "req_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        self.requestID = try container.decodeIfPresent(String.self, forKey: .requestID)
        
        switch self.type {
        case "ping":
            print("Ping!")
        case "table_snapshot":
            self.data = try container.decode(TableSnapshot.self, forKey: .data)
        case "action_trace":
            print("action_trace")
            self.data = try container.decode(ActionTrace.self, forKey: .data)
        case "listening":
            print("listening")
        default:
            print("Warning: unknown incoming message [\(self.type)]")
        }
        //todo: switch on type and init model with decoder
//        let sdataContainer = container.nestedUnkeyedContainer(forKey: .data)
    }
}
