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
    let location: Place
    let image: URL
}

struct Place: Decodable {
    let name: String
    let url: URL
}

struct Location: Decodable {
    let name: String
    let type: String
    let dimension: String
}


