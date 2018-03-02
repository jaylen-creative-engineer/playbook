//
//  Contacts.swift
//  pursue
//
//  Created by Jaylen Sanders on 3/1/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Contacts

struct Contacts {
    
    let firstname : String
    let lastname : String
    let phoneNumber : String
    let is_selected = false
    
    init(contact : CNContact) {
        self.firstname = contact.givenName
        self.lastname = contact.familyName
        self.phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
    }
}
