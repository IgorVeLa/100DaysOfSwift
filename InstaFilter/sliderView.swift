//
//  sliderView.swift
//  InstaFilter
//
//  Made for challenge 2
//
//  Created by Igor L on 20/01/2024.
//
//

import Foundation
import SwiftUI

extension String {
    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                if $0.count > 0 {
                    return ($0 + " " + String($1))
                }
            }
            return $0 + String($1)
        }
    }
}

struct sliderView: View {
    var inputKey: String
    @Binding var sliderValue: Double
    @Binding var activeModifiers: Bool
    
    var body: some View {
        HStack {
            Text(inputKey.camelCaseToWords())
                .textCase(.lowercase)
                .opacity(activeModifiers ? 1 : 0.24)
            Slider(value: $sliderValue)
        }
    }
}

#Preview {
    sliderView(inputKey: "inputIntensity", sliderValue: .constant(0.5), activeModifiers: .constant(true))
}
