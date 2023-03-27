//
//  GenreModels.swift
//  ListenNotes
//
//  Created by Alexandr Chernets on 27.03.2023.
//

import Foundation

struct GenreResult: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let parentID: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentID = "parent_id"
    }
}
