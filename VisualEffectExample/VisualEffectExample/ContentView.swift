//
//  ContentView.swift
//  VisualEffectExample
//
//  Created by Jose Alberto Rosario Castillo on 13/10/24.
//

import SwiftUI

struct ContentView: View {
    
    private var screenWidth: CGFloat = .init(UIScreen.main.bounds.width)
    
    var body: some View {
        
        ZStack {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(1..<11) { item in
                        HStack {
                            ZStack {
                               
                                Circle()
                                    .fill(Color.blue)
                                    .frame(height: 50)
                                    .padding(4)
                                Text("\(item)")
                                    .foregroundStyle(.white)
                            }
                            .visualEffect { content, proxy in
                                let frame = proxy.frame(in: .global)
                                let screenWidth = self.screenWidth
                                
                                let centerXScreen = screenWidth / 2
                                
                                let distanceX = abs(centerXScreen - frame.midX)
                                
                                let scale = 1.5 - (distanceX / centerXScreen)
                                
                                let hueRotationDegrees = Angle.degrees((1 - distanceX) / -1.50)
                                
                                return content
                                    .scaleEffect(scale)
                                    .hueRotation(hueRotationDegrees)
                                    .brightness(distanceX / centerXScreen * 0.3)
                            }
                        }
                        .scrollTargetLayout()
                    }
                }
                
            }
            .defaultScrollAnchor(.center)
            .contentMargins(.horizontal, screenWidth / 2)
        }
    }
}

#Preview {
    ContentView()
}
