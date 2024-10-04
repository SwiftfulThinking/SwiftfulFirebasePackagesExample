////
////  SignInPhoneView.swift
////  SwiftfulFirebasePackagesExample
////
////  Created by Nick Sarno on 4/19/24.
////
//
//import SwiftUI
//
//struct SignInPhoneView: View {
//    
//    @Environment(\.auth) private var authManager
//    @Environment(RootState.self) private var root
//
//    @State private var errorAlert: AnyAppAlert? = nil
//
//    @State private var phoneNumber: String = ""
//    @State private var code: String = ""
//    @State private var didSendCode: Bool = false
//
//    var body: some View {
//        List {
//            TextField("12341234", text: $phoneNumber)
//                .font(.headline)
//            
//            Button(action: {
//                onSubmitPressed()
//            }, label: {
//                Text("Submit")
//            })
//            .disabled(phoneNumber.count < 5)
//            
//            if didSendCode {
//                Section("CODE") {
//                    TextField("284039", text: $code)
//                        .keyboardType(.numberPad)
//                        .textContentType(.oneTimeCode)
//                    
//                    Button(action: {
//                        onCodeSubmitPressed()
//                    }, label: {
//                        Text("Submit")
//                    })
//                    .disabled(code.count < 3)
//                }
//            }
//        }
//        .showCustomAlert(alert: $errorAlert)
//        .navigationTitle("+ Phone Number")
//    }
//    
//    func onSubmitPressed() {
//        Task {
//            do {
//                try await authManager.signInPhone_Start(phoneNumber: phoneNumber)
//                didSendCode = true
//            } catch {
//                errorAlert = AnyAppAlert(error: error)
//            }
//        }
//    }
//    
//    func onCodeSubmitPressed() {
//        Task {
//            do {
//                let (authUser, isNewUser) = try await authManager.signInPhone_Verify(code: code)
//                root.updateViewState(showTabbar: true)
//            } catch {
//                errorAlert = AnyAppAlert(error: error)
//            }
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        SignInPhoneView()
//            .environment(RootState())
//    }
//}
