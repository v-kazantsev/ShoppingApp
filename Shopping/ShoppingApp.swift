//
//  ShoppingApp.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

@main
struct ShoppingApp: App {
    
    @StateObject private var vm = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
