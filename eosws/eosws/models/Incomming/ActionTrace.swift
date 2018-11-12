//
//  ActionTrace.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct ActionTrace: Decodable {
    public let blockNum: Int
    public let blockID: String
    public let transactionID: String
    public let actionIndex: Int
    public let actionDepth: Int
    public let trace: [String:JSONValue]?
    public let dbops: [String:JSONValue]?
    public let ramConsumed: [String:JSONValue]?
    public let deferredTransactions: [String:JSONValue]?
    
    enum CodingKeys: String, CodingKey {
        case blockNum = "block_num"
        case blockID = "block_id"
        case trace, dbops
        case transactionID = "trx_id"
        case actionIndex = "idx"
        case actionDepth = "depth"
        case ramConsumed = "rams"
        case deferredTransactions = "dtrxs"
    }
}
