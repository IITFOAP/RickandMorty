//
//  ViewController.swift
//  RickandMorty
//
//  Created by Рома Баранов on 06.05.2023.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet var namelessButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        namelessButton.layer.cornerRadius = namelessButton.frame.width / 2
    }
    
    @IBAction func getParse() {
        fetchHero()
    }
    
    private func fetchHero() { // хотел сделать сразу в методе кнопки, но боюсь, что это будет ошибкой
        let connection = URL(string: "https://rickandmortyapi.com/api/character/108")!
        
        URLSession.shared.dataTask(with: connection) { data,_ ,error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            let hero = try? decoder.decode(Hero.self, from: data)
            print(hero ?? "")
        }.resume()
    }
}

