//
//  eosws.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//
import SwiftWebSocket

enum EOSWSError: Error {
    case invalidURL(url: String)
}

public class EOSWS{
    
    let endpoint: String
    let token: String
    let origin: String
    let ws: WebSocket
    
    public var delegate : EOSWSDelegate?
    
    public init(forEnpoint endpoint: String, token: String, origin: String) throws {
        self.endpoint = endpoint
        self.token = token
        self.origin = origin
        
        print("In init of EOSWS")
        
        let urlString = "\(endpoint)?token=\(token)"
        
        guard let url = URL(string: urlString) else {
            throw EOSWSError.invalidURL(url: urlString)
        }
        
        let ws = WebSocket(url: url)
        self.ws = ws

        ws.event.open = {
            print("opened")
        }
        ws.event.close = { code, reason, clean in
            print("connection close")
        }
        ws.event.error = { error in
            print("error \(error)")
            //todo: notify delegate
        }
        ws.event.message = { message in
            if let text = message as? String {
//                print("eosws: Received message: \(text)")
                if let data = text.data(using: String.Encoding.utf8) {
                    do {
                        let message = try JSONDecoder().decode(IncomingMessage.self, from: data)
                        if let delegate = self.delegate {
                            if let messageData = message.data {
                                delegate.messageReveiced(msgData: messageData)
                            }
                        }
                    } catch {
                        //todo send error to delegate?
                        print("JSON decode error: \(error)")
                    }
                    
                    return
                }
            }
        }
    }
    
    public func send(json: String) {
        print("eosws: Sending json: \(json)")
        ws.send(json)
    }
    
    public func close() {
        print("eosws: Closing connection")
        ws.close()
    }
}

public protocol EOSWSDelegate {
    
    func messageReveiced(msgData: MessageData)
    
}
