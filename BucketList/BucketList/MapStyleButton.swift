//
//  MapStyleButton.swift
//  BucketList
//
//  Created by Igor L on 30/01/2024.
//

import Foundation
import SwiftUI

struct MapStyleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .frame(width: 44, height: 44)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
