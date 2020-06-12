//
//  EmptyView.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/11/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Text("Congrats, no fb URLs found.")
            .font(.headline)
            .padding()
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
