//
//  AddBookView.swift
//  BookWorm
//
//  Created by Igor L on 04/01/2024.
//

import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                            Text($0)
                    }
                }
            }
            
            Section("Write a review") {
                TextEditor(text: $review)
                RatingView(rating: $rating)
            }
            
            Section {
                Button("Save") {
                    let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                    modelContext.insert(newBook)
                    dismiss()
                }
            }
            // challenge 1
            .disabled(title.isEmpty || author.isEmpty)
        }
        .navigationTitle("Add Book")
    }
}

#Preview {
    AddBookView()
}
