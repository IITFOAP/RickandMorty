//
//  Hero.swift
//  RickandMorty
//
//  Created by Рома Баранов on 06.05.2023.
//

struct Hero: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Name
    let location: Name
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
struct Name: Decodable {
    let name: String
    let url: String
}


