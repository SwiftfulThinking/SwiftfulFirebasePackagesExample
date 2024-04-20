//
//  CreateAccountView.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import SwiftUI
import SwiftfulFirebaseAuth
import Firebase

struct CreateAccountView: View {
    
    @Environment(\.auth) private var authManager
    @Environment(RootState.self) private var root

    @State private var errorAlert: AnyAppAlert? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 8) {
                Rectangle()
                    .fill(Color.orange)
                    .ignoresSafeArea()
                
                VStack(spacing: 8) {
                    Text("Sample App")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("by SwiftfulThinking")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 24)
                
                VStack(spacing: 8) {
                    SignInWithAppleButtonView()
                        .frame(height: 55)
                        .asButton {
                            signInWithAppleButtonPressed()
                        }

                    SignInWithGoogleButtonView()
                        .frame(height: 55)
                        .asButton {
                            signInWithGoogleButtonPressed()
                        }
                }
                .padding()

                HStack(spacing: 8) {
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        Text("Terms of Service")
                            .underline()
                    })
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 4, height: 4)
                    Link(destination: URL(string: "https://www.apple.com")!, label: {
                        Text("Privacy Policy")
                            .underline()
                    })
                    
                }
            }
            .padding(.bottom, 24)
        }
        .showCustomAlert(alert: $errorAlert)
    }
    
    @MainActor
    func signInWithAppleButtonPressed() {
        Task {
            do {
                let (authUser, isNewUser) = try await authManager.signInApple()
                root.updateViewState(showTabbar: true)
            } catch {
                // Error signing in (user still not signed in)
                // Show alert
                errorAlert = AnyAppAlert(error: error)
            }
        }
    }
    
    @MainActor
    func signInWithGoogleButtonPressed() {
        Task {
            do {
                guard let clientId = FirebaseApp.app()?.options.clientID else {
                    throw URLError(.cannotCreateFile)
                }
                
                let (authUser, isNewUser) = try await authManager.signInGoogle(GIDClientID: clientId)
                root.updateViewState(showTabbar: true)
            } catch {
                // Error signing in (user still not signed in)
                // Show alert
                errorAlert = AnyAppAlert(error: error)
            }
        }
    }
}

#Preview {
    CreateAccountView()
        .environment(RootState())
}
