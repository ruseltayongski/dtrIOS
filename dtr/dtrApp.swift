//
//  dtrApp.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/16/23.
//

import SwiftUI
import SwiftData
@main
struct dtrApp: App {
    @StateObject private var userData = CurrentUser()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(userData)
        }
        .modelContainer(for: [OfficeOrder.self, Cto.self])
    }
}
