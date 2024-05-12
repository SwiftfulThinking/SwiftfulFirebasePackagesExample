//
//  SettingsView.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/19/24.
//

import SwiftUI
import Firebase
import SwiftfulFirebaseAuth

struct SettingsView: View {
    
    @Environment(\.auth) private var authManager
    @Environment(RootState.self) private var root

    @State private var userIsAnonymous: Bool = false
    @State private var errorAlert: AnyAppAlert? = nil

    var body: some View {
        NavigationStack {
            List {
                Button("Log out") {
                    onSignOutPressed()
                }
                
                if userIsAnonymous {
                    VStack {
                        SignInWithAppleButtonView()
                            .frame(height: 55)
                            .asButton {
                                Task { @MainActor in
                                    do {
                                        let (authUser, isNewUser) = try await authManager.signInApple()
                                        userIsAnonymous = authUser.isAnonymous
                                    } catch {
                                        print(error)
                                        errorAlert = AnyAppAlert(error: error)
                                    }
                                }
                            }
                        
                        Text("Click here to test linking anonymous to Apple SSO.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                userIsAnonymous = authManager.currentUser.profile?.isAnonymous == true
            }
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
