//
//  ContentView.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/9/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import SwiftUI
import Contacts

struct ContentView: View {
    @ObservedObject var viewModel = ContactsViewModel()
    var deleteFBURLsFromContacts: (() -> Void)
    @State private var showingAlert = false
    
    var body: some View {
        VStack {            
            VStack(alignment: .leading) {
                Text("Your contacts with fb:// URLs")
                    .font(.title)
                
                Text("Found \(viewModel.contacts.count) contact\(viewModel.contacts.count == 1 ? "" : "s")")
                    .font(.subheadline)
            }
            .padding()

            List(viewModel.contacts) { c in
                VStack(alignment: .leading) {
                    Text(c.name)
                        .font(.system(size: 18, weight: Font.Weight.bold, design: Font.Design.default))
                    Text(c.urls)
                        .font(.system(size: 12, weight: Font.Weight.light, design: Font.Design.default))
                }
                .padding()
            }
            
            Button("Delete these FB URLs from these contacts", action: {
                self.showingAlert = true
            })
                .buttonStyle(BlueButtonStyle())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Final warning"),
                          message: Text("You are about to remove fb:// URLs from \(viewModel.contacts.count) contacts."),
                        primaryButton: .destructive(Text("Delete"), action: {
                            self.deleteFBURLsFromContacts()
                    }),
                        secondaryButton: .cancel(Text("Cancel"))
                    )
                }

            Text("There is no going back. Proceed with caution.")
                .padding()
                .font(.footnote)
            
            VStack {
                Text("You may want to backup before proceeding.")
                    .font(.callout)
                    .padding(Edge.Set.bottom, 4)
            
                Button("Learn how to backup your Contacts", action: {
                    let url = URL(string: "https://support.apple.com/guide/contacts/export-and-archive-contacts-adrbdcfd32e6/mac")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                })
            }
                .padding()
        }
            .frame(maxWidth: 450)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContactsViewModel(
            [
                FBContact(id: "id1", name: "my name a", urls: "fb://asdfasdf"),
                FBContact(id: "id2", name: "my name b", urls: "fb://asdfasdf"),
                FBContact(id: "id3", name: "my name c", urls: "fb://asdfasdf"),
                FBContact(id: "id4", name: "my name d", urls: "fb://asdfasdf"),
                FBContact(id: "id5", name: "my name e", urls: "fb://asdfasdf"),
                FBContact(id: "id6", name: "my name f", urls: "fb://asdfasdf"),
                FBContact(id: "id7", name: "my name g", urls: "fb://asdfasdf"),
                FBContact(id: "id8", name: "my name h", urls: "fb://asdfasdf"),
                FBContact(id: "id9", name: "my name i", urls: "fb://asdfasdf"),
                FBContact(id: "id10", name: "my name j", urls: "fb://asdfasdf"),
                FBContact(id: "id11", name: "my name k", urls: "fb://asdfasdf"),
                FBContact(id: "id12", name: "my name l", urls: "fb://asdfasdf"),
                FBContact(id: "id13", name: "my name m", urls: "fb://asdfasdf"),
                FBContact(id: "id14", name: "my name n", urls: "fb://asdfasdf"),
                FBContact(id: "id15", name: "my name o", urls: "fb://asdfasdf"),
                FBContact(id: "id16", name: "my name p", urls: "fb://asdfasdf"),
                FBContact(id: "id17", name: "my name q", urls: "fb://asdfasdf"),
                FBContact(id: "id18", name: "my name r", urls: "fb://asdfasdf"),
                FBContact(id: "id19", name: "my name s", urls: "fb://asdfasdf")
            ]
        ), deleteFBURLsFromContacts: {})
    }
}
