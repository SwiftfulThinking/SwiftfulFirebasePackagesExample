//
//  CreateAccountView.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import SwiftUI
import SwiftfulAuthenticating
import SwiftfulAuthUI
import Firebase

struct CreateAccountView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(RootState.self) private var root

    @State private var errorAlert: AnyAppAlert? = nil
    @State private var showPhoneView: Bool = false

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
                    SignInAnonymousButtonView()
                        .frame(height: 55)
                        .asButton {
                            signInAnonymousPressed()
                        }

                    SignInAppleButtonView()
                        .frame(height: 55)
                        .asButton {
                            signInWithAppleButtonPressed()
                        }

                    SignInGoogleButtonView()
                        .frame(height: 55)
                        .asButton {
                            signInWithGoogleButtonPressed()
                        }
                    
//                    SignInWithPhoneButtonView()
//                        .frame(height: 55)
//                        .asButton {
//                            signInWithPhoneButtonPressed()
//                        }
//                        .fullScreenCover(isPresented: $showPhoneView, content: {
//                            NavigationStack {
//                                SignInPhoneView()
//                            }
//                        })
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
    
    @MainActor
    func signInAnonymousPressed() {
        Task {
            do {
                let (authUser, isNewUser) = try await authManager.signInAnonymous()
                root.updateViewState(showTabbar: true)
            } catch {
                // Error signing in (user still not signed in)
                // Show alert
                errorAlert = AnyAppAlert(error: error)
            }
        }
    }
    @MainActor
    func signInWithPhoneButtonPressed() {
        showPhoneView = true
    }
}

#Preview {
    CreateAccountView()
        .environment(RootState())
}
