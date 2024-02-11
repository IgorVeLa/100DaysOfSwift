//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Igor L on 29/12/2023.
//


import SwiftUI


struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    // challenge 2
    @State private var showingRequestFail = false
    @State private var requestFailMsg = ""

    var body: some View {
        ScrollView {
            VStack {
                Group {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                            image
                                .resizable()
                                .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                } 
                // project 15: challenge 1
                .accessibilityHidden(true)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                            .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        // challenge 2
        .alert("POST request failed", isPresented: $showingRequestFail) {
            Button("OK") { }
        } message: {
            Text(requestFailMsg)
        }
    }
    
    // Send a JSON encoded type of our Order object to the server
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        // force unwrap URL object
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            // challenge 2
            requestFailMsg = "\(error.localizedDescription)"
            showingRequestFail = true
        }
    }
}


#Preview {
    CheckoutView(order: Order())
}
