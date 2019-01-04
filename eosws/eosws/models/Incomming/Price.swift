//
//  Price.swift
//  eosws
//
//  Created by Charles Billette on 2018-01-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

public struct Price: Decodable {
    public let symbol: String
    public let price: Float64
    public let variation:  Float64
    public let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case symbol, price, variation
        case lastUpdated = "last_updated"
    }
}
