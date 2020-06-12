//
//  FBCleanupTests.swift
//  FBCleanupTests
//
//  Created by Robert Tolar Haining on 6/9/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import XCTest
@testable import FBCleanup
import Contacts

class FBCleanupTests: XCTestCase {

    var contactStore: CNContactStore!
    var contactsCleaner: ContactsCleaner!
        
    override func setUpWithError() throws {
        contactStore = CNContactStore()
        contactsCleaner = ContactsCleaner()
    }

    override func tearDownWithError() throws {
        try cleanupTestContacts()
        contactStore = nil
    }

    func testEmptyContacts() throws {
        contactsCleaner.fetch { (contacts, error) in
            XCTAssertEqual(contacts?.count, 0)
            XCTAssertNil(error)
        }
    }
    
    func testSomeContacts() throws {
        try genericTest(count: 5)
    }
    
    func testLotsOfContacts() throws {
        try genericTest(count: 100)
    }
    
    func genericTest(count: Int) throws {
        try addTestContacts(count: count)
        
        contactsCleaner.fetch { [weak self] (contacts, error) in
            XCTAssertEqual(contacts?.count, count)
            XCTAssertNil(error)
            
            self!.contactsCleaner.cleanFacebookContacts(contacts!)
            
            self!.contactsCleaner.fetch { (contacts, error) in
                XCTAssertEqual(contacts?.count, 0)
                XCTAssertNil(error)
            }
            
            let contacts = self!.contactsCleaner.fetchAllContacts()
                .compactMap { (c) -> CNContact? in
                    return c.familyName == "Monster" ? c : nil
            }
            let randomContact = contacts.randomElement()!
            XCTAssertEqual(randomContact.urlAddresses.count, 0)
        }

    }

}

extension FBCleanupTests {
    func addTestContacts(count: Int) throws {
        let saveRequest = CNSaveRequest()
        
        for i in 0..<count {
            let c = CNMutableContact()
            c.givenName = "Fred \(i)"
            c.familyName = "Monster"
            c.urlAddresses = [
                CNLabeledValue(label: CNLabelHome, value: "fb://abcdef_\(i)" as NSString)
            ]
            
            saveRequest.add(c, toContainerWithIdentifier: nil)
        }
        
        try contactStore.execute(saveRequest)
    }

    func cleanupTestContacts() throws {
        let contacts = contactsCleaner.fetchAllContacts()
            .compactMap { (c) -> CNContact? in
                return c.familyName == "Monster" ? c : nil
        }
        
        let saveRequest = CNSaveRequest()
        for c in contacts {
            if let mutableContact = c.mutableCopy() as? CNMutableContact {
                saveRequest.delete(mutableContact)
            }
        }
        
        try contactStore.execute(saveRequest)
    }

}
