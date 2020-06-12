//
//  BlueButtonStyle.swift
//  FBCleanup
//
//  Created by Robert Tolar Haining on 6/11/20.
//  Copyright © 2020 Robert Tolar Haining. All rights reserved.
//

import Foundation
import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .foregroundColor(.white)
            .background(Color(red: 14/255.0, green: 115/255.0, blue: 237/255.0))
            .cornerRadius(10)
    }
}

