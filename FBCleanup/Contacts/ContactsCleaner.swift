//
//  ContactsCleaner.swift
//  FacebookCleanup
//
//  Created by Robert Tolar Haining on 6/9/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import Foundation
import Contacts

class ContactsCleaner {
    let contactStore = CNContactStore()
    
    func fetch(completion: @escaping (([CNContact]?, Error?) -> Void)) {
        contactStore.requestAccess(for: .contacts) { [weak self] (success, error) in
            if success {
                let matchingContacts = self?.fetchFacebookContacts()
                completion(matchingContacts, nil)
            } else {
                NSLog("error \(String(describing: error))")
                completion(nil, error)
            }
        }
    }
    
    private func fetchFacebookContacts() -> [CNContact] {
        let allContacts = fetchAllContacts()
        let facebookedContacts = allContacts.compactMap { (contact) -> CNContact? in
            for url in contact.urlAddresses where url.value.contains("fb://") {
                return contact
            }
            return nil
        }
        
        return facebookedContacts
        
    }
    
    func deleteFacebookURLs(from contacts: [CNContact]) {
        var contactsToSave: [CNMutableContact] = []
        
        for contact in contacts {
            let mutableContact = contact.mutableCopy() as! CNMutableContact
            
            var urlAddresses = mutableContact.urlAddresses
            urlAddresses.removeAll { (contactProperty) -> Bool in
                contactProperty.value.contains("fb://")
            }
            
            mutableContact.urlAddresses = urlAddresses
            contactsToSave.append(mutableContact)
        }
        
        save(contacts: contactsToSave)
    }
    private func save(contacts: [CNMutableContact]) {
        let saveRequest = CNSaveRequest()

        for c in contacts {
            saveRequest.update(c)
        }

        do {
            try contactStore.execute(saveRequest)
        } catch {
            NSLog("error savingt he store: \(error)")
        }

    }
    
    func fetchAllContacts() -> [CNContact] {
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactUrlAddressesKey as CNKeyDescriptor,
            CNSocialProfileURLStringKey as CNKeyDescriptor
        ]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers: \(error)")
        }
        
        var results: [CNContact] = []
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate,
                                                                        keysToFetch: keysToFetch)
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }

        return results
    }
}
