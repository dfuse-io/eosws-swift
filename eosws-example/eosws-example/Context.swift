//
//  Context.swift
//  eosws-example
//
//  Created by Charles Billette on 2018-11-12.
//  Copyright © 2018 dfuse. All rights reserved.
//

import Foundation
import eosws


class Context {
    
    private init() {}
    static let shared = Context()
    
    enum Notification: String {
        case actionTrace
        case tablesSnapshot
        case tableDelta
        case transactionLifecycle
        case listening
        case price
        case chainInfo
        case account
        case voteTally
        case error
    }

    
    var eosws: EOSWS! {
        didSet {
            eosws.delegate = self
        }
    }
}


extension Context: EOSWSDelegate {
    func messageReceived(msgData: MessageData) {
        
        switch msgData {
        case .actionTrace(let actionTrace):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.actionTrace.rawValue), object:actionTrace)
        case .tableSnapshot(let tableSnapshat):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.tablesSnapshot.rawValue), object:tableSnapshat)
        case .tableDelta(let tableDelta):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.tableDelta.rawValue), object:tableDelta)
        case .transactionLifecycle(let transactionLifecycle):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.transactionLifecycle.rawValue), object:transactionLifecycle)
        case .listening(let listening):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.listening.rawValue), object:listening)
        case .chainInfo(let chainInfo):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.chainInfo.rawValue), object:chainInfo)
        case .price(let price):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.price.rawValue), object:price)
        case .account(let account):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.account.rawValue), object:account)
        case .voteTally(let voteTally):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.voteTally.rawValue), object:voteTally)
        case .error(let err):
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.error.rawValue), object:err)
        }
    }
}
