//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Igor L on 18/04/2024.
//

import SwiftUI

extension HorizontalAlignment {
    struct MenuAndList: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.leading]
        }
    }

    static let menuAndList = HorizontalAlignment(MenuAndList.self)
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var favourites = Favourites()
    
    @State private var sortResorts = [Resort]()
    @State private var searchText = ""
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            if sortResorts.isEmpty {
                resorts
            } else {
                sortResorts
            }
        } else {
            if sortResorts.isEmpty {
                resorts.filter { $0.name.localizedStandardContains(searchText) }
            } else {
                sortResorts.filter { $0.name.localizedStandardContains(searchText) }
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack(alignment: .menuAndList) {
                Menu("Sort by") {
                    Button("Default", action: defaultSort)
                    Button("A-Z", action: alphabeticalSort)
                    Button("Country", action: countrySort)
                }
                .alignmentGuide(.menuAndList) { d in d[HorizontalAlignment.leading] }
                //.border(.blue)
                
                List(filteredResorts) { resort in
                    NavigationLink(value: resort) {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    .rect(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                            
                            if favourites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .alignmentGuide(.menuAndList) { d in d[HorizontalAlignment.leading] }
                    //.border(.yellow)
                }
                //.border(.green)
                .scrollContentBackground(.hidden)
                .navigationTitle("Resorts")
                .navigationDestination(for: Resort.self) { resort in
                    ResortView(resort: resort)
                }
                .searchable(text: $searchText, prompt: "Search for a resort")
            }
            //.border(.black)
            
        } detail: {
            WelcomeView()
        }
        .environment(favourites)
    }
    
    func defaultSort() {
        sortResorts = resorts
    }
    
    func alphabeticalSort() {
        sortResorts = resorts.sorted(by: {
            return $0.name < $1.name
        })
    }
    
    func countrySort() {
        sortResorts = resorts.sorted(by: {
            return $0.country < $1.country
        })
    }
}

#Preview {
    ContentView()
}
