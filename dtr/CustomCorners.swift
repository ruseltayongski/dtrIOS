//
//  CustomCorners.swift
//  dtr
//
//  Created by Rusel T. Tayong on 4/20/23.
//

import SwiftUI

//Custom Corners Shape...
struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
