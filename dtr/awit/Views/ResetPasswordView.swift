//
//  ResetPasswordView.swift
//  dtr
//
//  Created by ICTU1 on 11/7/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var userid_reset: String = ""
    @State private var showModal: Bool = false
    @State var user: String = ""
    @State var userid: String = (CurrentUser().id ?? "")
    @EnvironmentObject var userData: CurrentUser
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "lock.open")
                    .font(Font.system(size: 128))
                TextField("Enter ID", text: $userid_reset)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Reset Password"){
                    print(CurrentUser().lname ?? "n")
                    print(userData.lname ?? "noneL")
                    Task {
                        user = await checkUserName(userid: userid_reset, domain: userData.domain) ?? ""
                        if (user != ""){
                            showModal.toggle()
                        }
                        else {
                            print("User does not exist")
                        }
                    }
                }.sheet(isPresented: $showModal) {
                    ZStack{
                        Color.black.opacity(0.5)
                            .background(BackgroundClearView())
                            .edgesIgnoringSafeArea(.all)
                        ModalReset(userid_reset: $userid_reset, username: $user, userid: $userid, showModal: $showModal)
                    }
                }
            }
        }    }
}

struct ModalReset: View {
    @Environment(\.dismiss) var dismiss
    @Binding var userid_reset: String
    @Binding var username: String
    @Binding var userid: String
    @Binding var showModal: Bool
    @EnvironmentObject var userData: CurrentUser
    var body: some View {
        VStack {
            Text("Are you sure you want to reset the password of \(username)")
            HStack {
                Button("Cancel") {
                    showModal.toggle()
                }
                .padding()
                .foregroundColor(.red)
                
                Button("Confirm") {
                    Task {
                        let result = await resetPassword(userid: userid, reset_userid: userid_reset, domain: userData.domain)
                        showModal.toggle()
                    }
                }
                .background(Color.green)
                .padding()
                
            }
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .environment(\.colorScheme, .light)
        .cornerRadius(10)
        .padding(25)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
