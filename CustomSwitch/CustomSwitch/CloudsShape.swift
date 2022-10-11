//
//  CloudsShape.swift
//  CustomSwitch
//
//  Created by Pratik on 09/10/22.
//

import SwiftUI

struct CloudsShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        
        let circle1: CGRect = CGRect(x: 0, y: rect.maxY - rect.width/10, width: rect.width/5, height: rect.width/5)
        path.addEllipse(in: circle1)
        
        let circle2: CGRect = CGRect(x: circle1.width/2, y: rect.maxY - rect.width/6, width: rect.width/3, height: rect.width/3)
        path.addEllipse(in: circle2)
        
        let circle3: CGRect = CGRect(x: circle2.midX, y: rect.maxY - circle2.height, width: rect.width/2, height: rect.width/2)
        path.addEllipse(in: circle3)
        return path
    }
}


struct CloudsShape_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
//            Color.gray
//                .ignoresSafeArea()
            CloudsShape()
                .fill(Color.cyan)
//                .fill(LinearGradient(colors: [Color.cyan, Color.white.opacity(0.0001)], startPoint: .top, endPoint: .bottom))
                .frame(width: 200, height: 100, alignment: .center)
                .clipped()
        }
    }
}
