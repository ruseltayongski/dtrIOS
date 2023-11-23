//
//  HomeView.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/16/23.
//

import SwiftUI

struct HomeView: View {
    @State var preferredColumn: NavigationSplitViewColumn = NavigationSplitViewColumn.detail
    @Environment(\.dismiss) private var dismiss
    @State var userData = CurrentUser()
    @Binding var isLoggedIn: Bool
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn){
            VStack {
                HStack{
                    VStack {
                        Image("doh")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .cornerRadius(10)
                        Text((userData.fname ?? "NA") + " " + (userData.lname ?? "NA"))
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Text("View Profile")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                }.frame(maxWidth: .infinity).background(Color.blue)
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
                    NavigationLink {
                        ResetPasswordView()
                    } label: {
                        Image(systemName: "lock.open")
                        Text("Reset DTR Password")
                    }
                }
            }
            Button("Logout"){
                userData.logout()
                isLoggedIn.toggle()
            }
        } detail: {
            DailyTimeRecord()
        }.navigationBarHidden(true)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(isLoggedIn: .constant(true))
    }
}

extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
