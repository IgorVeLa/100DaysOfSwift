//
//  CrewView.swift
//  MoonShot
//
//  Created by Igor L on 30/11/2023.
//

// Challenge 2
import SwiftUI
import Foundation

struct CrewView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        HStack {
            ForEach(crew, id: \.role) { crewMember in
                NavigationLink {
                    AstronautView(astronaut: crewMember.astronaut)
                } label: {
                    HStack {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return CrewView(crew: MissionView(mission: missions[1], astronauts: astronauts).crew)
        .preferredColorScheme(.dark)
}
