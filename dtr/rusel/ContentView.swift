//
//  ContentView.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/16/23.
//

import CoreTelephony
import SwiftUI

struct ContentView: View {
    @State private var showingLoginScreen = false
    @State private var showingLoginFailed = false
    @State private var modalPublicIp = false
    @State private var modalUDID = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                VStack {
                    Spacer() //spacer to align button right
                    Image("doh")
                        .resizable()
                        .frame(width: 130,height: 130)
                        .padding(10)
                    Text("DTR CVCHD 7")
                        .font(.largeTitle)
                        .bold()
                    Text("IOS Version 1.0.0")
                    NavigationLink(destination: HomeView()) {
                        Text("LOGIN")
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top,15)
                    Spacer()
                    HStack {
                        Button("Public IP") {
                            modalPublicIp = true
                        }
                        .sheet(isPresented: $modalPublicIp) {
                            ZStack {
                                Color.black.opacity(0.5)
                                    .background(BackgroundClearView())
                                    .edgesIgnoringSafeArea(.all)
                                ModalUpdateIP()
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.init(red: 0, green: 0, blue: 1))
                        .cornerRadius(10)
                        Spacer()
                        Button("UDID") {
                            modalUDID = true
                        }
                        .sheet(isPresented: $modalUDID) {
                            ZStack {
                                Color.black.opacity(0.5)
                                    .background(BackgroundClearView())
                                    .edgesIgnoringSafeArea(.all)
                                ModalUDID()
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 100, height: 50)
                        .background(Color.init(red: 0, green: 0, blue: 1))
                        .cornerRadius(10)
                    }
                    
                } //end vstack
            } // end zstack
        }.navigationBarHidden(true)
    }
}

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct ModalUpdateIP: View {
    @Environment(\.presentationMode) var presentationMode
    @State var publicIp: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Public IP", text: $publicIp)
                .padding()
            HStack {
                Button("Save") {
                    // Save data
                    self.presentationMode.wrappedValue.dismiss()
                }
                .background(Color.green)
                .padding()
                
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.red)
            }
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .environment(\.colorScheme, .light)
        .cornerRadius(10)
        .padding(25)
    }
}

struct ModalUDID: View {
    @Environment(\.presentationMode) var presentationMode
    @State var UDID: String = " \(UIDevice.current.identifierForVendor?.uuidString ?? "unknown")"
    @State var userid: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Public IP", text: $UDID)
                .padding()
            TextField("Enter UserId", text: $userid)
                .padding()
            HStack {
                Button("Save") {
                    // Save data
                    self.presentationMode.wrappedValue.dismiss()
                }
                .background(Color.green)
                .padding()
                
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .foregroundColor(.red)
            }
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .environment(\.colorScheme, .light)
        .cornerRadius(10)
        .padding(25)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
