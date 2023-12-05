//
//  JsonData.swift
//  dtr
//
//  Created by ICTU1 on 11/29/23.
//

import Foundation

struct JsonData: Encodable {
    var data: String
    
    init(data: String) {
        self.data = data
    }
}
