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
    case tableDelta(TableDelta)
    case actionTrace(ActionTrace)
    case transactionLifecycle(TransactionLifecycle)
    case listening(Listening)
    case price(Price)
    case chainInfo(ChainInfo)
    case account(Account)
    case voteTally(VoteTally)
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
            self.data = MessageData.tableDelta(data)

        case "action_trace":
            let data = try container.decode(ActionTrace.self, forKey: .data)
            self.data = MessageData.actionTrace(data)

        case "transaction_lifecycle":
            let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
            enum CodingKeys: String, CodingKey {
                case lifecycle
            }
            let data = try nested.decode(TransactionLifecycle.self, forKey: CodingKeys.lifecycle)
            self.data = MessageData.transactionLifecycle(data)

        case "listening":
            let data = try container.decode(Listening.self, forKey: .data)
            self.data = MessageData.listening(data)

        case "price":
            let data = try container.decode(Price.self, forKey: .data)
            self.data = MessageData.price(data)

        case "head_info":
            let data = try container.decode(ChainInfo.self, forKey: .data)
            self.data = MessageData.chainInfo(data)

        case "account":
            let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
            enum CodingKeys: String, CodingKey {
                case account
            }
            let data = try nested.decode(Account.self, forKey: CodingKeys.account)
            self.data = MessageData.account(data)

        case "vote_tally":
            let nested = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
            enum CodingKeys: String, CodingKey {
                case voteTally = "vote_tally"
            }
            let data = try nested.decode(VoteTally.self, forKey: CodingKeys.voteTally)
            self.data = MessageData.voteTally(data)

        case "error":
            let data = try container.decode(ErrorMessage.self, forKey: .data)
            self.data = MessageData.error(data)

        default:
            print("Warning: unknown incoming message [\(self.type)]")
        }
    }
}
