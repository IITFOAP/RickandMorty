//
//  ListHeroesViewController.swift
//  RickandMorty
//
//  Created by Рома Баранов on 09.05.2023.
//

import UIKit

final class ListHeroesViewController: UITableViewController {
    // MARK: - Private Properties
    private var heros: [Hero] = []
    private var images: [Data] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHero()

    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let min = min(
            heros.count,
            images.count
        )
        
        return min
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listHeroes", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let hero = heros[indexPath.row]
        let image = images[indexPath.row]
        
        content.text = hero.name
        content.secondaryText = "Status \(hero.status)"
        
        content.image = UIImage(data: image)
        content.imageProperties.cornerRadius = (content.image?.size.width ?? 10) / 2
        
        content.textProperties.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        tableView.rowHeight = 100
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let infoVC = segue.destination as? InfoViewController else { return }
            infoVC.hero = heros[indexPath.row]
        }
    }
    
    // MARK: - Private Methods
    private func fetchHero() {
        let urls = Link.firstHero.url
        
        for url in urls {
            networkManager.fetch(Hero.self, from: url) { [weak self] result in
                switch result {
                case .success(let hero):
                    self?.networkManager.fetchImage(from: hero.image) { [weak self] result in
                        switch result {
                        case .success(let imageData):
                            self?.heros.append(hero)
                            self?.images.append(imageData)
                            self?.tableView.reloadData()
                        case .failure(let error):
                            print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

