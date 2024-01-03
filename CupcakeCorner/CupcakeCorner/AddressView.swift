//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Igor L on 29/12/2023.
//


import SwiftUI


struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
                .disabled(order.hasValidAddress == false)
            }
        }
    }
}


#Preview {
    AddressView(order: Order())
}
