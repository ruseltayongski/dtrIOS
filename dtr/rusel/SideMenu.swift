//
//  SideMenu.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/20/23.
//

import SwiftUI

//struct SideMenu: View {
//    @Binding var selectedTab: String
//    @Namespace var animation
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15,content: {
//            
//            Image("doh")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 70, height: 70)
//                .cornerRadius(10)
//                .padding(.top,50)
//            
//            VStack(alignment: .leading,spacing: 6, content: {
//                
//                Text("Rusel T. Tayong")
//                    .font(.title)
//                    .fontWeight(.heavy)
//                    .foregroundColor(.white)
//                
//                Text("View Profile")
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
//                    .opacity(0.7)
//            })
//            
//            VStack(alignment:.leading,spacing: 0) {
//                TabButton(image: "clock.arrow.circlepath", title: "Daily Time Record", selectedTab: $selectedTab, animation: animation)
//                
//                TabButton(image: "house", title: "Area Assignment", selectedTab: $selectedTab, animation: animation)
//                
//                TabButton(image: "bell.badge", title: "Notification", selectedTab: $selectedTab, animation: animation)
//                
//                TabButton(image: "gearshape.fill", title: "Settings", selectedTab: $selectedTab, animation: animation)
//                
//                TabButton(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, animation: animation)
//                
//                TabButton(image: "lock.open",
//                    title: "Reset Password",
//                    selectedTab: $selectedTab,
//                    animation: animation)
//            }
//            .padding(.leading,-15)
//            .padding(.top,50)
//            
//            Spacer()
//            
//            // Sign out button...
//            TabButton(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Logout", selectedTab: .constant(""), animation: animation)
//                .padding(.leading,-15)
//            
//            Text("App Version 1.2.24")
//                .font(.caption)
//                .fontWeight(.semibold)
//                .foregroundColor(.white)
//                .opacity(0.6)
//            
//        })
//        .padding()
//        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
//    }
//}
//
//struct SideMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
