//
//  AsButtonViewModifier.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import Foundation
import SwiftUI

extension View {
    
    func asButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}
