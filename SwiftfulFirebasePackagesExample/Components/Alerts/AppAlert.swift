//
//  AppAlert.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import Foundation
import SwiftUI

protocol AppAlert {
    var title: String { get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

struct AnyAppAlert: AppAlert {
    var title: String
    var subtitle: String? = nil
    var buttons: AnyView = {
        AnyView(
            Button("OK", action: {
                
            })
        )
    }()
    
    init(title: String, subtitle: String? = nil, buttons: AnyView? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", action: {
                    
                })
            )
        }()
    }
    
    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}

enum AlertType {
    case alert, confirmationDialog
}

extension View {
        
    @ViewBuilder func showCustomAlert<T: AppAlert>(type: AlertType = .alert, alert: Binding<T?>) -> some View {
        switch type {
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert), actions: {
                    alert.wrappedValue?.buttons
                }, message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                })
        case .confirmationDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert), actions: {
                    alert.wrappedValue?.buttons
                }, message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                })
        }
    }
    
}

fileprivate extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}
