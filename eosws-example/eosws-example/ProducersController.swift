//
//  ViewController.swift
//  eosws-example
//
//  Created by Charles Billette on 2018-11-09.
//  Copyright © 2018 dfuse. All rights reserved.
//

import UIKit
import eosws

struct Producer {
    let name: String
    var totalVote: Double = 0
    init(withName name: String) {
        self.name  = name
    }
}

class ProducersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var producers: [Producer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //todo : unregister all observers
        //todo : register for tableDelta
        NotificationCenter.default.addObserver(
            self, selector:
            #selector(self.handleTableSnapshot(notification:)),
            name: NSNotification.Name(rawValue: Context.Notification.tablesSnapshot.rawValue),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self, selector:
            #selector(self.handleTableDelta(notification:)),
            name: NSNotification.Name(rawValue: Context.Notification.tableDelta.rawValue),
            object: nil
        )

        fetchProducers()
    }
    
    func fetchProducers(){
        let getTableRowsRequest = GetTableRows(withAccount: "eosio", scope: "eosio", table: "producers")
        do {
            try getTableRowsRequest.send(with: Context.shared.eosws, withRequestID: "abc", listen: true)
        } catch {
            //todo: implement visual alert here
            print(error)
        }
    }
    
    @objc func handleTableSnapshot(notification: Notification) {
        print("Received producers table snapshop")
        let snapshop = notification.object as! TableSnapshot
        self.producers = []
        
        for (_, row) in snapshop.rows.enumerated() {
            var producer = Producer(withName: row.key)
            
            if let json = row.json {
                if case .double(let vote) = json["total_votes"]! {
                    producer.totalVote = vote
                }
                
            }
            self.producers.append(producer)
        }
        
//        self.producers = self.producers.sorted(by: { (p1, p2) -> Bool in
//            return p1.totalVote > p2.totalVote
//        })
        self.tableView.reloadData()
    }
    
    @objc func handleTableDelta(notification: Notification) {
        
        let delta = notification.object as! TableDelta
        print("Received table delta: \(delta)")
    }

}

extension ProducersViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.producers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let producer = self.producers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "producerCell")!
        cell.textLabel?.text = producer.name
        cell.detailTextLabel?.text = String(producer.totalVote)
        return cell
    }
}

