//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Igor L on 26/03/2024.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: proxy.frame(in: .global).maxX * rowScale(screenY: fullView.frame(in: .global).maxY, yOffset: proxy.frame(in: .global).minY))
                            .background(colourScale(yOffset: proxy.frame(in: .global).minY))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .opacity(fadeOpacity(yOffset: proxy.frame(in: .global).minY))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
                                        
    func colourScale(yOffset: CGFloat) -> Color {
        var hueValue = min((0.001 * yOffset), 1.0)
        let colour = Color(hue: hueValue, saturation: 1.0, brightness: 1.0)
        return colour
    }
    
    func rowScale(screenY: CGFloat, yOffset: CGFloat) -> CGFloat {
        return max(0.5, (0.0025 * yOffset))
    }
    
    func fadeOpacity(yOffset: CGFloat) -> Double {
        return max(0, 1 - (200 - yOffset) / 200)
    }
}

#Preview {
    ContentView()
}
