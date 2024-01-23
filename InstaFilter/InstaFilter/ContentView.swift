//
//  ContentView.swift
//  InstaFilter
//
//  Created by Igor L on 17/01/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI
import StoreKit

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State private var filterIntensity = 0.5
    @State private var radiusIntensity = 0.5
    @State private var scaleIntensity = 0.5
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    // challenge 1
    @State private var activeModifiers = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                VStack {
                    VStack {
                        ForEach(currentFilter.inputKeys, id: \.self) { inputKey in
                            Group {
                                if processedImage != nil {
                                    if inputKey == "inputIntensity" {
                                        sliderView(inputKey: inputKey, sliderValue: $filterIntensity, activeModifiers: $activeModifiers)
                                            .onChange(of: filterIntensity, applyProcessing)
                                    } else if inputKey == "inputRadius" {
                                        sliderView(inputKey: inputKey, sliderValue: $radiusIntensity, activeModifiers: $activeModifiers)
                                            .onChange(of: radiusIntensity, applyProcessing)
                                    } else if inputKey == "inputScale" {
                                        sliderView(inputKey: inputKey, sliderValue: $scaleIntensity, activeModifiers: $activeModifiers)
                                            .onChange(of: scaleIntensity, applyProcessing)
                                    }
                                }
                            }
                        }
                    }
                    

                    HStack {
                        Button("Change Filter", action: changeFilter)
                        
                        Spacer()
                        
                        if let processedImage {
                            ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                        }
                    }
                }
                // challenge 1
                .disabled(!activeModifiers)
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                // challenge 3
                Button("Circular Warp") { setFilter(CIFilter.circularWrap())}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                activeModifiers = false
                return
            }
            guard let inputImage = UIImage(data: imageData) else {
                activeModifiers = false
                return
            }

            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            activeModifiers = true
            
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        print(currentFilter.currentInputValues())
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radiusIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(scaleIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1

        if filterCount >= 20 {
            requestReview()
        }
    }
    
    func changeFilter() {
        showingFilters.toggle()
    }
}

#Preview {
    ContentView()
}
