//
//  Response.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public enum MessageData {
    case tableSnapshot(TableSnapshot)
    case tableDetla(TableDelta)
    case actionTrace(ActionTrace)
    case transactionLifecycle(TransactionLifecycle)
    case listening(Listening)
    case error(ErrorMessage)
}

public struct IncomingMessage: Decodable {
    let type : String
    var requestID : String?
    var data: MessageData?

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
            let data = try container.decode(TableSnapshot.self, forKey: .data)
            self.data = MessageData.tableSnapshot(data)
        case "table_delta":
            let data = try container.decode(TableDelta.self, forKey: .data)
            self.data = MessageData.tableDetla(data)
        case "action_trace":
            let data = try container.decode(ActionTrace.self, forKey: .data)
            self.data = MessageData.actionTrace(data)
        case "transaction_lifecycle":
            let data = try container.decode(TransactionLifecycle.self, forKey: .data)
            self.data = MessageData.transactionLifecycle(data)
        case "listening":
            let data = try container.decode(Listening.self, forKey: .data)
            self.data = MessageData.listening(data)
        case "error":
            let data = try container.decode(ErrorMessage.self, forKey: .data)
            self.data = MessageData.error(data)
        default:
            print("Warning: unknown incoming message [\(self.type)]")
        }
    }
}
