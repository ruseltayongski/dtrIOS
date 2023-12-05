//
//  View_toastView.swift
//  dtr
//
//  Created by ICTU1 on 12/1/23.
//

import SwiftUI

extension View {

  func toastView(toast: Binding<Toast?>) -> some View {
    self.modifier(ToastModifier(toast: toast))
  }
}
