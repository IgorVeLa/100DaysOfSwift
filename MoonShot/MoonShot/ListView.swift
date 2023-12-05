//
//  ListView.swift
//  MoonShot
//
//  Created by Igor L on 30/11/2023.
//

// Challenge 3
import SwiftUI
import Foundation


struct ListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
//                NavigationLink {
//                    MissionView(mission: mission, astronauts: astronauts)
//                } label: {
                NavigationLink(value: mission) {
                    HStack {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .padding(.horizontal)
                    }
                }
                // Project 9 Challenge 3
                .navigationDestination(for: Mission.self) { mission in
                    MissionView(mission: mission, astronauts: astronauts)
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListView(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
