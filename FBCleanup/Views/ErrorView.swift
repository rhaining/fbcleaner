//
//  ErrorView.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/11/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import SwiftUI
import Contacts

struct ErrorView: View {
    var error: Error
    var openSettings: (() -> Void)
    var cnError: CNError? { return error as? CNError }
    
    var body: some View {
        VStack {
            Text(error.localizedDescription)
                .font(.headline)
                .padding()

            Text(cnError?.userInfo[NSLocalizedFailureReasonErrorKey] as? String ?? "")
                .font(.subheadline)
                .padding()

            Button("⚙️ Open Settings", action: openSettings)
                .buttonStyle(BlueButtonStyle())
                .padding()

        }
            .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: CNError(CNError.Code.authorizationDenied), openSettings: {})
    }
}
