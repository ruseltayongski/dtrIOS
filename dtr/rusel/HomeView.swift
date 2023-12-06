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
    @State var announcement: Announcement?
    @State var showAnnouncement: Bool = false
    @State var count: Int = 0
    @State var message: String? = nil
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
                NavigationItems()
            }.sheet(isPresented: $showAnnouncement){
                ModalMessage(announcement: $announcement)
            }
            Button("Logout"){
                userData.logout()
                isLoggedIn.toggle()
            }
        } detail: {
            DailyTimeRecord()
        }.navigationBarHidden(true)
            .onAppear(){
                Task {
                    do {
                        announcement = await getAnnouncement(domain: userData.domain)
                        if announcement?.code == 1 {
                            DispatchQueue.main.async {
                                message = announcement?.message
                                showAnnouncement.toggle()
                                print(message ?? "none")
                            }
                        } else {
                            print("No announcement")
                        }
                    }
                }
            }
    }
}

struct ModalMessage: View {
    @Environment(\.dismiss) var dismiss
    @Binding var announcement: Announcement?
    var body: some View {
        VStack {
            Text(announcement?.message ?? "none")
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .environment(\.colorScheme, .light)
        .cornerRadius(10)
        .presentationDetents([.medium, .large])
        .padding(20)
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
