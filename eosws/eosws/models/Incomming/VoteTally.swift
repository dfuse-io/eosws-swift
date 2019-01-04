//
//  VoteTally.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-02.
//  Copyright © 2019 dfuse. All rights reserved.
//

import Foundation

public struct VoteTally: Decodable {
    
    public let totalActivatedStake: Float64
    public let totalVotes: Float64
    public let decayWeight:Float64
    public let producers: [Producer]
    
    enum CodingKeys: String, CodingKey {
        case totalActivatedStake = "total_activated_stake"
        case totalVotes = "total_votes"
        case decayWeight = "decay_weight"
        case producers = "producers"
    }
}

public struct Producer: Decodable {
    public let owner: String
    public let totalVotes: Float64
    public let producerKey: String
    public let isActive: Bool
    public let url: String
    public let unpaidBlocks: Int
    public let location: Int
    
    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case totalVotes = "total_votes"
        case producerKey = "producer_key"
        case isActive = "is_active"
        case url = "url"
        case unpaidBlocks = "unpaid_blocks"
        case location = "location"
    }
}
