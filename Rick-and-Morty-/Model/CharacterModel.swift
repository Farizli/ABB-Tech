//
//  CharacterModel.swift
//  Rick-and-Morty-
//
//  Created by Ali  Farizli  on 28.10.22.
//

import Foundation

struct ApiData: Codable{
    let info: Info?
    let results: [Results]?
}
struct Info: Codable{
    let pages: Int?
}

struct Results: Codable{
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin
    let location: Location?
    let image: URL?
    let episode: [URL]?
    let url: URL?
    
    
}
struct Origin: Codable{
    let name: String?
    let url: String?
}
struct Location: Codable{
    let name: String?
    let url: String?
}

