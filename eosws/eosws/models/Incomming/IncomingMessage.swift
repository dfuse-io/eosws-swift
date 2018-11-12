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
    var data: Any? // this should not be optional

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
        case "table_delta":
            self.data = try container.decode(TableDelta.self, forKey: .data)
        case "action_trace":
            self.data = try container.decode(ActionTrace.self, forKey: .data)
        case "transaction_lifecycle":
            self.data = try container.decode(TransactionLifecycle.self, forKey: .data)
        case "listening":
            self.data = try container.decode(Listening.self, forKey: .data)
        case "error":
            self.data = try container.decode(ErrorMessage.self, forKey: .data)
        default:
            print("Warning: unknown incoming message [\(self.type)]")
        }
    }
}
