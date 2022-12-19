//
//  ContentView.swift
//  Shopping
//
//  Created by mac on 19.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.red)
                .ignoresSafeArea()
            ZStack {
                Text("Test")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
