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
    private let networkManager = NetworkManager.shared

    // MARK: - View Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHero()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heros.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listHeroes", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let hero = heros[indexPath.row]
        
        content.text = hero.name
        content.secondaryText = "Status \(hero.status)"
        
        content.image = UIImage(named: "Rick")
        content.imageProperties.cornerRadius = (content.image?.size.width ?? 10) / 2
        
        content.textProperties.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
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
        let urls = Link.allCases

        for link in urls {
            let url = link.url

            networkManager.fetch(Hero.self, from: url) { [weak self] result in
                switch result {
                case .success(let hero):
                    self?.heros.append(hero)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
