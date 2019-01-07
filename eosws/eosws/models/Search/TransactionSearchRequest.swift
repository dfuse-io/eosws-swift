//
//  TransactionSearchRequest.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-04.
//  Copyright © 2019 dfuse. All rights reserved.
//

import Foundation

public struct TransactionSearchRequest {

    let query: String
    let startBlock: Int?
    let sort: String?
    let blockCount: Int?
    let limit: Int?
    let cursor: String?

    public init(query: String, startBlock: Int?, sort: String?, blockCount: Int?, limit: Int?, cursor: String?) {
        self.query = query
        self.startBlock = startBlock
        self.sort = sort
        self.blockCount = blockCount
        self.limit = limit
        self.cursor = cursor
    }

    public func get(withEOSWS eosws: EOSWS) throws {



    }
}
