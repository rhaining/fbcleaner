//
//  ContactsViewModel.swift
//  FacebookCleanup
//
//  Created by Robert Tolar Haining on 6/10/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import Foundation

final class ContactsViewModel: ObservableObject {
    @Published var contacts: [FacebookContact]
    
    init() {
        contacts = []
    }
    init(_ contacts: [FacebookContact]) {
        self.contacts = contacts
    }
}
