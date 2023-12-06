//
//  NavigationItems.swift
//  dtr
//
//  Created by ICTU1 on 12/5/23.
//

import SwiftUI

struct NavigationItems: View {
    @State var userData = CurrentUser()
    var body: some View {
        List {
            NavigationLink {
                DailyTimeRecord()
            } label: {
                Image(systemName: "clock.arrow.circlepath")
                Text("Daily Time Record")
            }
            NavigationLink {
                MapViewContent()
            } label: {
                Image(systemName: "house")
                Text("Area Assignment")
            }
            NavigationLink {
                OfficeOrderView()
            } label: {
                Image(systemName: "newspaper")
                Text("Office Order")
            }
            NavigationLink {
                CTOView()
            } label: {
                Image(systemName: "doc.badge.clock")
                Text("Compensatory Time Off")
            }
            NavigationLink {
                Notification()
            } label: {
                Image(systemName: "bell.badge")
                Text("Notification")
            }
            NavigationLink {
                Settings()
            } label: {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
            NavigationLink {
                Help()
            } label: {
                Image(systemName: "questionmark.circle")
                Text("Help")
            }
            if(userData.authority == "reset_password"){
                NavigationLink {
                    ResetPasswordView()
                } label: {
                    Image(systemName: "lock.open")
                    Text("Reset DTR Password")
                }
            }
        }
    }
}

#Preview {
    NavigationItems()
}
