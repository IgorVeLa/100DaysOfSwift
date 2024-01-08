//
//  ContentView.swift
//  BookWorm
//
//  Created by Igor L on 04/01/2024.
//


import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var ModelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                                // challenge 2
                                .foregroundStyle(book.rating == 1 ? Color.red : Color.primary)
                            Text(book.author)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .navigationDestination(for: Book.self) { book in
                        DetailView(book: book)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("BookWorm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find book in offset
            let book = books[offset]
            
            // remove from db
            ModelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
