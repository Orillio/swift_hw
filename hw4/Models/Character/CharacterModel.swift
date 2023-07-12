//
//  CharacterModel.swift
//  HW4
//
//  Created by Ян Козыренко on 08.07.2023.
//

import Foundation

struct CharacterModel: Codable {
    
    let results: [Character]
    
    struct Location: Codable {
        var name: String
        var url: String
    }
    struct Character: Codable {
        var id: Int
        var name: String
        var status: String
        var species: String
        var gender: String
        var location: Location
        var image: String
    }
    enum CodingKeys: String, CodingKey {
        case results
    }
}
