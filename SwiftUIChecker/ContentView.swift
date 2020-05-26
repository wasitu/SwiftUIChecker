//
//  ContentView.swift
//  SwiftUIChecker
//
//  Created by Seiya Shimokawa on 4/7/20.
//  Copyright © 2020 wasitu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("NavigationView", destination: NavigationViewChecker())
            }
            .navigationBarTitle("SwiftUIChecker")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
