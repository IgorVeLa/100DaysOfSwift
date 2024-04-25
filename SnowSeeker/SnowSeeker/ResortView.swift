//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Igor L on 23/04/2024.
//

import Foundation
import SwiftUI

struct ResortView: View {
    // Find size of class and switch to 2x2 if needed
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let resort: Resort
    @Environment(Favourites.self) var favourites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                        
                    // challenge 1
                    Text(resort.imageCredit)
                        .padding(1)
                        .background(RoundedRectangle(cornerRadius: 2).fill(Color.white))
                        .opacity(0.8)
                        .offset(x: -5, y: -5)
                        .font(horizontalSizeClass == .compact ? .caption : .subheadline)
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favourites.contains(resort) ? "Remove from Favourites" : "Add to Favorites") {
                if favourites.contains(resort) {
                    favourites.remove(resort: resort)
                } else {
                    favourites.add(resort: resort)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        // _ is used as Facility instance is not needed
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favourites())
}
