//
//  Toast.swift
//  dtr
//
//  Created by ICTU1 on 12/1/23.
//

import Foundation

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
