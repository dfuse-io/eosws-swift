//
//  Account.swift
//  eosws
//
//  Created by Charles Billette on 2019-01-02.
//  Copyright © 2019 dfuse. All rights reserved.
//

import Foundation

public struct Account: Decodable {
    
    public let name: String
    public let privileged: Bool
    public let lastCodeUpdateTime: String
    public let creationTime: String
    public let coreLiquidBalance: Asset
    
    public let ramQuota: Int
    public let ramUsage: Int
    
    public let netWeight: Int
    public let cpuWeight: Int
    
    public let netLimit: AccountResourceLimit
    public let cpuLimit: AccountResourceLimit
    
    public let permissions: [Permission]
    
    public let totalResources: TotalResources
    
    public let delegatedBandwidth: DelegatedBandwidth
    public let refundRequest: RefundRequest?
    public let voterInfo: VoterInfo
    
    
    enum CodingKeys: String, CodingKey {
        case name = "account_name"
        case privileged = "privileged"
        case lastCodeUpdateTime = "last_code_update"
        case creationTime = "created"
        case coreLiquidBalance = "core_liquid_balance"
        
        case ramQuota = "ram_quota"
        case ramUsage = "ram_usage"
        
        case netWeight = "net_weight"
        case cpuWeight = "cpu_weight"
        
        case netLimit = "net_limit"
        case cpuLimit = "cpu_limit"
        
        case permissions = "permissions"
        case totalResources = "total_resources"
        case delegatedBandwidth = "self_delegated_bandwidth"
        case refundRequest = "refund_request"
        case voterInfo = "voter_info"
    }
}

enum AssetError: Error {
    case missingSymbol
    case invalidAmount
    case missingPrecision
}
public struct Asset: Decodable {
    public let amount: Int
    public let precision: Int
    public let symbol: String
    
    
    public init(from decoder: Decoder) throws {
        let s = try decoder.singleValueContainer().decode(String.self)
        
        if s == "" || s == "0 "{
            self.amount = 0
            self.precision = 0
            self.symbol = ""
            return
        }
        
        let assetParts = s.split(separator: " ")
        
        if assetParts.count < 2 {
            throw AssetError.missingSymbol
        }
        self.symbol = String(assetParts[1])

        let amountString = String(assetParts[0])
        let amountParts = amountString.split(separator: ".")
        if amountParts.count < 2 {
            throw AssetError.missingPrecision
        }
        self.precision = amountParts[1].count

        if let a = Double(amountString){
            self.amount = Int(a * pow(10.0, Double(self.precision)))
        }else{
            throw AssetError.invalidAmount
        }
        
    }
}

public struct AccountResourceLimit: Decodable  {
    public let used: Int
    public let available: Int
    public let max: Int
}

public struct Permission: Decodable {
    public let permName: String
    public let parent: String
    public let requiredAuth: Authority
    
    enum CodingKeys: String, CodingKey {
        case permName = "perm_name"
        case parent = "parent"
        case requiredAuth = "required_auth"
    }
}

public struct Authority: Decodable {
    public let threshold: Int
    public let keys: [KeyWeight]?
    public let accounts: [PermissionLevelWeight]?
    public let waits: [WaitWeight]?
}

public struct KeyWeight: Decodable {
    public let key: String
    public let weight: Int
}

public struct PermissionLevelWeight: Decodable {
    public let permission: PermissionLevel
    public let weight: Int
}

public struct PermissionLevel: Decodable {
    public let actor: String
    public let permission: String
}

public struct WaitWeight: Decodable {
    public let waitSec: Int
    public let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case waitSec = "wait_sec"
        case weight = "weight"
    }
}

public struct TotalResources: Decodable {
    
    public let owner: String
    public let netWeight: String
    public let cpuWeight: String
    public let ramBytes: Int
    
    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case netWeight = "net_weight"
        case cpuWeight = "cpu_weight"
        case ramBytes = "ram_bytes"
    }
}

public struct DelegatedBandwidth: Decodable {
    public let from: String
    public let to: String
    public let netWeight: Asset
    public let cpuWeight: Asset
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case netWeight = "net_weight"
        case cpuWeight = "cpu_weight"
    }
}


public struct RefundRequest: Decodable {
    public let owner: String
    public let requestTime: String
    public let netAmount: String
    public let cpuAmount: String
    
    enum CodingKeys: String, CodingKey {
        case owner
        case requestTime
        case netAmount = "net_amount"
        case cpuAmount = "cpu_amount"
    }
    
}

public struct VoterInfo: Decodable {
    public let owner: String
    public let proxy: String
    public let producers: [String]?
    public let staked: Int
    public let lastVoteWeight: Float64
    public let proxiedVoteWeight: Float64
    public let isProxy: Int //todo: convert Int to Bool
    
    enum CodingKeys: String, CodingKey {
        case owner, proxy, producers, staked
        case lastVoteWeight = "last_vote_weight"
        case proxiedVoteWeight = "proxied_vote_weight"
        case isProxy = "is_proxy"
    }
}
