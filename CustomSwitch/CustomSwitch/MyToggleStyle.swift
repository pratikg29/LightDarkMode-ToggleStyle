//
//  MyToggleStyle.swift
//  CustomSwitch
//
//  Created by Pratik on 08/10/22.
//

import SwiftUI

struct MyToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { bounds in
            Button(action: {
//                withAnimation(.easeInOut) {
                    configuration.isOn.toggle()
//                }
            }, label: {
                ZStack {
                    background(isOn: configuration.isOn)
                    
                    LinearGradient(colors: [Color("borderDark"), Color("borderLight")], startPoint: .top, endPoint: .bottom)
                        .mask {
                            Capsule()
                                .stroke(lineWidth: 6)
                        }
                        .shadow(color: .black.opacity(0.8), radius: 6, x: 0, y: 7)
                    
                    HStack {
                        if !configuration.isOn {
                            Spacer(minLength: 0)
                        }
                        thumb()
                            .frame(width: bounds.size.height, height: bounds.size.height, alignment: .center)
                            .padding(.vertical, 13)
                        if configuration.isOn {
                            Spacer(minLength: 0)
                        }
                    }
                    .padding(.horizontal, 13)
                }
                .clipShape(Capsule())
            })
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder private func thumb() -> some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.08))
                .scaleEffect(2.8)
            
            Circle()
                .fill(Color.white.opacity(0.08))
                .scaleEffect(2.2)
            
            Circle()
                .fill(Color.white.opacity(0.08))
                .scaleEffect(1.6)
            
            Circle()
                .fill(Color("thumb"))
                .overlay {
                    ZStack {
                        LinearGradient(colors: [Color("thumbBorderDark"), Color("thumbBorderLight")], startPoint: .bottom, endPoint: .top)
                            .mask {
                                Circle()
                                    .stroke(lineWidth: 3)
                        }
                    }
                }
                .shadow(color: .black.opacity(0.6), radius: 20, x: 0, y: 10)
        }
    }
    
    @ViewBuilder private func background(isOn: Bool) -> some View {
        ZStack {
            Color("toggleBg")
            
            HStack {
                if isOn {
                    Spacer(minLength: 0)
                    Image("cloud")
                        .resizable()
                        .scaledToFit()
                        .padding(.trailing, 20)
                        .transition(.opacity)
                } else {
                    StarsGenerator()
//                        .transition(.opacity)
                }
            }
        }
    }
    
    private struct StarsGenerator: View {
        static let starDefaultSize: CGFloat = 10
        static let defaultXPsotion: CGFloat = 50
        static let defaultYPsotion: CGFloat = 30
        
        @State private var stars: [StarModel] = []
        var body: some View {
            GeometryReader { bounds in
                ZStack {
                    ForEach(stars) { s in
                        Star(corners: 4, smoothness: 0.45)
                            .frame(width: s.size.width, height: s.size.height, alignment: .center)
                            .transition(.opacity)
                            .offset(x: s.offset.x, y: s.offset.y)
                    }
                }
                .frame(width: bounds.size.width, height: bounds.size.height, alignment: .center)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        for _ in 0...12 {
                            let size = CGFloat.random(in: 5...15)
                            stars.append(StarModel(offset: CGPoint(x: CGFloat.random(in: -bounds.size.width/2...bounds.size.width/2), y: CGFloat.random(in: -bounds.size.height/2...bounds.size.height/2)),
                                                   size: CGSize(width: size, height: size)))
                        }
                    }
                }
                .onReceive(Timer.publish(every: 1, on: .current, in: .default).autoconnect()) { _ in
                    withAnimation(.easeInOut(duration: 1)) {
                        stars.removeFirst()
                        let size = CGFloat.random(in: 5...15)
                        stars.append(StarModel(offset: CGPoint(x: CGFloat.random(in: -bounds.size.width/2...bounds.size.width/2), y: CGFloat.random(in: -bounds.size.height/2...bounds.size.height/2)),
                                               size: CGSize(width: size, height: size)))
                    }
                }
            }
        }
        
        private struct StarModel: Identifiable {
            var id = UUID()
            var offset: CGPoint
            var size: CGSize
        }
    }
}

struct Toggle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()
            
            Toggle("", isOn: .constant(true))
                .frame(width: 300, height: 100, alignment: .center)
                .toggleStyle(MyToggleStyle())
        }
    }
}
