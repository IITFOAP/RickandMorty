//
//  Hero.swift
//  RickandMorty
//
//  Created by Рома Баранов on 06.05.2023.
//

import Foundation

struct Hero: Decodable {
    
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: URL
}

struct Location: Codable {
    let name: String?
    let url: URL?
    let type: String?
    let dimension: String?
    let residents: [URL]?
}


