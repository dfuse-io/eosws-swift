//
//  eosws.swift
//  eosws
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

enum EOSWSError: Error {
    case invalidURL(url: String)
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

public class EOSWS {

    let endpoint: String
    let restEndpoint: String
    let token: String
    let origin: String
    let ws: WebSocket

    public var delegate: EOSWSDelegate?

    public init(forEnpoint endpoint: String, restEndpoint: String, token: String, origin: String) throws {
        self.endpoint = endpoint
        self.restEndpoint = restEndpoint
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
                                delegate.messageReceived(msgData: messageData)
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

    func messageReceived(msgData: MessageData)

}

extension EOSWS {
    enum Result<T> {
        case success(T)
        case failure(EOSWSError)
    }


    func get<T: Decodable>(with queryString: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
        guard let url = URL(string: self.restEndpoint) else {
            completion(Result.failure(.invalidURL(url: self.restEndpoint)))
            return
        }

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil else {
                completion(Result.failure(EOSWSError.networkError(error!)))
                return
            }

            guard let data = data else {
                completion(Result.failure(EOSWSError.dataNotFound))
                return
            }

            do {
                //create decodable object from data
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(EOSWSError.jsonParsingError(error as! DecodingError)))
            }
        })

        task.resume()
    }
}
