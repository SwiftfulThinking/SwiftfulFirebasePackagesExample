//
//  RootView.swift
//  SwiftfulFirebasePackagesExample
//
//  Created by Nick Sarno on 4/18/24.
//

import SwiftUI

@Observable class RootState {
    private(set) var showTabbarView: Bool = UserDefaults.showTabbarView
    
    func updateViewState(showTabbar: Bool) {
        showTabbarView = showTabbar
        UserDefaults.showTabbarView = showTabbar
    }
}

struct RootView: View {
    
    @State private var viewState = RootState()

    var body: some View {
        RootViewBuilder(
            showTabbar: viewState.showTabbarView,
            tabbarView: {
                TabbarView()
            },
            onboardingView: {
                CreateAccountView()
            }
        )
        .environment(viewState)
    }
}

struct RootViewBuilder<TabbarView: View, OnboardingView: View>: View {
    
    let showTabbar: Bool
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboardingView: OnboardingView
        
    var body: some View {
        ZStack {
            if showTabbar {
                tabbarView
                    .transition(.move(edge: .trailing))
            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabbar)
    }
}

#Preview {
    RootView()
}

fileprivate extension UserDefaults {
    
    private enum Keys {
        static let showTabbarView = "showTabbarView"
    }
    
    static var showTabbarView: Bool {
        get {
            return standard.bool(forKey: Keys.showTabbarView)
        }
        set {
            standard.set(newValue, forKey: Keys.showTabbarView)
        }
    }
}
