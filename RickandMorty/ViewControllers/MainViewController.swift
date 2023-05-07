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
        let connection = URL(string: "https://rickandmortyapi.com/api/character/108")!
        
        URLSession.shared.dataTask(with: connection) { data,_ ,error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let hero = try decoder.decode(Hero.self, from: data)
                print(hero)
            } catch {
                print(error.localizedDescription )
            }
            
        }.resume()
    }
}

