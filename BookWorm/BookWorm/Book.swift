//
//  Book.swift
//  BookWorm
//
//  Created by Igor L on 04/01/2024.
//


import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    // challenge 3
    var date = Date.now
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = Date.now) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
