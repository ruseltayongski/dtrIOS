//
//  OfficeOrder.swift
//  dtr
//
//  Created by ICTU1 on 11/24/23.
//

import Foundation
import SwiftData

@Model
class OfficeOrder{
    @Attribute(.unique)
    var so_no: String
    var inclusive_date: String
    
    init(so_no: String, inclusive_date: String) {
        self.so_no = so_no
        self.inclusive_date = inclusive_date
    }
}
