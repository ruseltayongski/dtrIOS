//
//  LoginView.swift
//  dtr
//
//  Created by ICTU1 on 11/16/23.
//

import SwiftUI

struct LoginView: View {
    @State private var showingLoginScreen = false
    @State private var showingLoginFailed = false
    @State private var modalPublicIp = false
    @State private var modalUDID = false
    @State private var UDID: String = "\(UIDevice.current.identifierForVendor?.uuidString ?? "unknown")"
    @Binding var isLoggedIn: Bool 
    @EnvironmentObject var userData: CurrentUser
    var body: some View {
        NavigationStack {
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
                    Button("LOGIN"){
                        Task{
                            let result = await login(imei: UDID)
                            let user = result?.response
                            print(type(of: user?.section))
                            if(result?.code == 200){
                                userData.updateUser(
                                    id: user?.userid ?? "",
                                    fname: user?.fname ?? "",
                                    lname: user?.lname ?? "",
                                    authority: user?.authority ?? "", 
                                    
                                    dmo_roles: Int(user?.dmo_roles ?? 0),
                                    area_of_assignment_roles: Int(user?.area_of_assignment_roles ?? 0),
                                    region: user?.region ?? ""
                                    
                                )

                                isLoggedIn.toggle()
                            }
                        }
                    }.foregroundColor(.white)
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
@State var UDID: String = "\(UIDevice.current.identifierForVendor?.uuidString ?? "unknown")"
    @State var userid: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Public IP", text: $UDID)
                .padding()
            TextField("Enter UserId", text: $userid)
                .padding()
            HStack {
                Button("Update") {
                    // Save data
                    Task{
                        await updateIMEI(imei: UDID, userid: userid)
                    }
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

struct LoginViewPreview : PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(true))
    }
}
