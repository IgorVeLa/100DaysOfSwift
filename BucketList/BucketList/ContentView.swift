//
//  ContentView.swift
//  BucketList
//
//  Created by Igor L on 23/01/2024.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosiiton = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    let mapTypes = [MapStyle.standard, MapStyle.hybrid, MapStyle.imagery]
    @State var mapTypeIndex = 0
    @State var mapType: MapStyle = .standard
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack(alignment: .bottomTrailing) {
                MapReader { proxy in
                    Map(initialPosition: startPosiiton) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                        .mapStyle(mapType)
                        .onTapGesture { position in
                            // convert screen coords to map coords
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                                viewModel.save()
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                                viewModel.save()
                            }
                        }
                }
                // challenge 2
                .alert("Face ID is not available", isPresented: $viewModel.showingAuthenticate) {
                    
                } message: {
                    Text("Your device either has not set up face id or does not have it.")
                }
                .alert("Face ID failed", isPresented: $viewModel.showingAuthenticateEvaluate) {
                    
                } message: {
                    Text("Try again.")
                }
                
                // challenge 1
                Button {
                    mapStyleSwitch()
                } label: {
                    switch(mapTypeIndex) {
                    case 1:
                        Image(systemName: "square.3.layers.3d.middle.filled")
                    case 2:
                        Image(systemName: "square.3.layers.3d.bottom.filled")
                    default:
                        Image(systemName: "square.3.layers.3d.top.filled")
                    }
                    
                }
                .offset(x: -30, y: 0)
                .foregroundColor(.blue)
                .buttonStyle(MapStyleButton())
                .opacity(0.9)
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
    
    func mapStyleSwitch() {
        mapTypeIndex += 1
        if mapTypeIndex > 2 {
            mapTypeIndex = 0
        }
        mapType = mapTypes[mapTypeIndex]
    }
}

#Preview {
    ContentView()
}
