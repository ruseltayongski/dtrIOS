//
//  HomeView.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/16/23.
//

import SwiftUI

struct HomeView: View {
    //selected Tab...
    @State var selectedTab = "Daily Time Record"
    @State var showMenu = false
    //Animation Namespace...
    @Namespace var animation
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
        
            //Side menu
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                SideMenu(selectedTab: $selectedTab)
            })
            
            ZStack {
                //Two background Cards..
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    //shadow
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                    //shadow
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                Home(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
            }
            //Scaling and Moving the View...
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                Button(action: {
//                    withAnimation(.spring()) {
//                        showMenu.toggle()
//                    }
                    Task.init(priority: .medium) {
                        withAnimation(.spring()) {
                            showMenu.toggle()
                        }
                    }
                }, label: {
                    //Animated Drawer Button...
                    VStack(spacing: 5) {
                        Capsule()
                            .fill(showMenu ? Color.white : Color.primary)
                            .frame(width: 30, height: 3)
                        //Rotating
                            .rotationEffect(.init(degrees: showMenu ? -50 : 0))
                            .offset(x: showMenu ? 2 : 0)
                        
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                            //Moving up when clicked...
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                                .offset(y:showMenu ? -8 : 0)
                        }
                    }
                })
                .padding(),alignment: .topLeading
            )
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {
    func getRect()->CGRect {
        return UIScreen.main.bounds
    }
}
