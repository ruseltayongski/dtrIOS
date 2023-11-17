//
//  LoginHelper.swift
//  dtr
//
//  Created by ICTU1 on 11/16/23.
//

import Foundation

func getUserPreferences() -> Bool{
    var userSaved: Bool = false
    if(UserDefaults.standard.string(forKey: "userid") != nil){
        userSaved = true
    }
    return userSaved
}
