//
//  ContactsViewModel.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/10/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import Foundation

final class ContactsViewModel: ObservableObject {
    @Published var contacts: [FBContact]
    
    init() {
        contacts = []
    }
    init(_ contacts: [FBContact]) {
        self.contacts = contacts
    }
}
