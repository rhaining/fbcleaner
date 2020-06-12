//
//  FBContact.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/9/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import Foundation
import Contacts

struct FBContact: Identifiable {
    let id: String
    
    let name: String
    let urls: String
    
    init(contact: CNContact) {
        id = contact.identifier
        name = [contact.givenName, contact.middleName, contact.familyName]
            .compactMap({ (string) -> String? in
                return string.isEmpty ? nil : string
            })
            .joined(separator: " ")
        urls = contact.urlAddresses.compactMap({ (url) -> String? in
            return url.value.contains("fb://") ? url.value as String : nil
        }).joined(separator: ", ")
    }
    
    init(id: String, name: String, urls: String) {
        self.id = id
        self.name = name
        self.urls = urls
    }

}
