//
//  ResetPasswordView.swift
//  dtr
//
//  Created by ICTU1 on 11/7/23.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "lock.open")
                    .font(Font.system(size: 128))
                TextField("Enter text", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Reset Password"){
                }
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
