//
//  Home.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/21/23.
//

import SwiftUI

struct Home: View {
    @Binding var selectedTab: String
    
    // Hiding Tab Bar...
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        // Tab View with tabs...
        TabView(selection: $selectedTab) {
            //Views
            DailyTimeRecord()
                .tag("Daily Time Record")
            MapViewCirlcle()
                .tag("Area Assignment")
            Notification()
                .tag("Notification")
            Settings()
                .tag("Settings")
            Help()
                .tag("Help")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DailyTimeRecord: View {
    var body: some View {
        NavigationView {
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
        NavigationView {
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
        NavigationView {
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
        NavigationView {
            Text("Help")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
                .navigationTitle("Help")
        }
    }
}
