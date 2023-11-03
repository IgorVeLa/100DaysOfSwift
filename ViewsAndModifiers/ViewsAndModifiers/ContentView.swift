//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Igor L on 11/10/2023.
//

import SwiftUI

struct Title: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            Text(text)
                .padding()
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.blue)
        }
    }
}

extension View {
    func titleStyle(with text: String) -> some View {
        modifier(Title(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        Color.orange
            .frame(width: 300, height: 200)
            .titleStyle(with: "Hacking with Swift")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
