//
//  ciFilter.swift
//  InstaFilter
//
//  Created by Igor L on 21/01/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation

extension CIFilter {
    // store values for input keys (i.e filterIntensity)
    // used for @State to be read and updated in views
    func currentInputValues() {
        var inputValues: [String: Double] = [:]
        print(inputValues)
        
        print("------")
        print(self.attributes)
        let defaultValue = self.attributes["CIAttributeSliderMax"] as! Double
        print(defaultValue)
//        forEach (self.inputKeys) { inputKey in
//            inputValues[inputKey : self.]
//        }
    }
    
    // sets values for input keys
    func setInputValues() {
    }
}
