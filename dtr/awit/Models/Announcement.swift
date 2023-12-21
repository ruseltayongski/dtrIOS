//
//  Announcement.swift
//  dtr
//
//  Created by ICTU1 on 12/5/23.
//

import Foundation

struct Announcement: Codable {
    var code: Int
    var message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
}
