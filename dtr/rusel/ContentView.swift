//
//  ContentView.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/16/23.
//

import CoreTelephony
import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = getUserPreferences()
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        }
        else {
            HomeView(isLoggedIn: $isLoggedIn)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
