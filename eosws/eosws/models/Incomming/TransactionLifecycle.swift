//
//  TransactionLifecycle.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation

public struct TransactionLifecycle: Decodable {
    
    let id: String
    let transaction: JSONValue
    let executionTrace: JSONValue
    let executionBlockHeader: JSONValue
    let dtrxops: [JSONValue]
    let ramops: [JSONValue]
    let publicKeys: [String]
    let createdBy: JSONValue?
    let canceledBy: JSONValue
    let executionIrreversible: Bool
    let creationIrreversible: Bool
    let cancelationIrreversible: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case transaction
        case executionTrace = "execution_trace"
        case executionBlockHeader = "execution_block_header"
        case dtrxops = "dtrxops"
        case ramops = "ramops"
        case publicKeys = "pub_keys"
        case createdBy = "created_by"
        case canceledBy = "cancel_by"
        case executionIrreversible = "execution_irreversible"
        case creationIrreversible = "creation_irreversible"
        case cancelationIrreversible = "cancelation_irreversible"
    }
}
