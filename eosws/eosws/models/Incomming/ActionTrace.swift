//
//  ActionTrace.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct ActionTrace: Decodable {
    let blockNum: Int
    let blockID: String
    let transactionID: String
    let actionIndex: Int
    let actionDepth: Int
    let trace: [String:JSONValue]?
    let dbops: [String:JSONValue]?
    let ramConsumed: [String:JSONValue]?
    let deferredTransactions: [String:JSONValue]?
    
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
