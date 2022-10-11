//
//  ContentView.swift
//  CustomSwitch
//
//  Created by Pratik on 08/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var isLightMode: Bool = false
    
    var body: some View {
        ZStack {
            background
            
            Toggle("", isOn: $isLightMode.animation(.easeInOut))
                .frame(width: 300, height: 100, alignment: .center)
                .toggleStyle(MyToggleStyle())
        }
        .preferredColorScheme(isLightMode ? .light : .dark)
    }
    
    @ViewBuilder private var background: some View {
        if isLightMode {
            Color("lightBg")
                .ignoresSafeArea()
        } else {
            Color("darkBg")
                .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
