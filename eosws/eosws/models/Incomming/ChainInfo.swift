//
//  ChainInfo.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-02.
//  Copyright © 2019 dfuse. All rights reserved.
//

public struct ChainInfo: Decodable {
    public let headBlockNum: Int
    public let headBlockID: String
    public let headBlockTime: String
    public let headBlockProducer: String
    public let libNum: Int
    public let libID: String
    
    enum CodingKeys: String, CodingKey {
        case headBlockNum = "head_block_num"
        case headBlockID = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case libNum = "last_irreversible_block_num"
        case libID = "last_irreversible_block_id"
    }
}

