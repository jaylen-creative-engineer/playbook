//
//  ChatDetailController.swift
//  pursue
//
//  Created by Jaylen Sanders on 9/5/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit

struct ChatMessage {
    let text : String
    let isIncoming : Bool
    let date : Date
}

extension Date {
    static func dateFromCustomString(customString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ChatDetailController : UITableViewController {
    
    let cellId = "id"
    
    let chatMessages = [
        [
            ChatMessage(text: "Here's my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ChatMessage(text: "I'm going to message another long message that going to word wrap.", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
            ],
        [
            ChatMessage(text: "I'm going to message another long message that going to word wrap. I'm going to message another long message that going to word wrap. I'm going to message another long message that going to word wrap.", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
            ChatMessage(text: "Yo, dawg, Whaddup!", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018"))
        ],
        [
            ChatMessage(text: "Third Section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/31/2018"))
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ChatDetailCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            return "Date : \(dateString)"
        }
        return "Section: \(Date())"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatDetailCell
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
    
}
