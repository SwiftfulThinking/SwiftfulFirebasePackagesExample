//
//  SettingsView.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/19/24.
//

import SwiftUI
import SwiftfulFirebaseAuth

struct SettingsView: View {
    
    @Environment(\.auth) private var authManager
    @Environment(RootState.self) private var root

    var body: some View {
        NavigationStack {
            List {
                Button("Log out") {
                    onSignOutPressed()
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    @MainActor
    private func onSignOutPressed() {
        do {
            try authManager.signOut()
            root.updateViewState(showTabbar: false)
        } catch {
            print(error)
        }
    }
}

#Preview {
    SettingsView()
        .environment(RootState())
}
