//
//  ImageView.swift
//  FriendFace
//
//  Created by Igor L on 24/02/2024.
//

import Foundation
import SwiftUI

struct ImageView: View {
    var friend: Friend
    
    var body: some View {
        friend.image
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fit)
        Text(friend.name)
            .font(.largeTitle)
    }
}

//#Preview {
//    ImageView(image: .)
//}
