//
//  Home.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/21/23.
//

import SwiftUI

struct Home: View {
    @State var preferredColumn: NavigationSplitViewColumn = NavigationSplitViewColumn.detail
    // Hiding Tab Bar...
    var body: some View {
        
        // Tab View with tabs...
        NavigationSplitView(preferredCompactColumn: $preferredColumn){
            List {
                
            }
        } detail: {
            DailyTimeRecord()
        }
    }
}

struct Home_Previews: PreviewProvider {
    @State private static var tab: String = "Reset Password" // Create a temporary @State property

    static var previews: some View {
        Home() // Pass the binding to the Home view
    }
}

struct DailyTimeRecord: View {
    var body: some View {
        NavigationStack {
            Text("Daily Time Record")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Daily Time Record")
        }
    }
}

struct Notification: View {
    var body: some View {
        NavigationStack {
            Text("Notification")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Notificaiton")
        }
    }
}

struct Settings: View {
    var body: some View {
        NavigationStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Settings")
        }
    }
}

struct Help: View {
    var body: some View {
        NavigationStack {
            Text("Help")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Help")
        }
    }
}
