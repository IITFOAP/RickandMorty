//
//  InfoViewController.swift
//  RickandMorty
//
//  Created by Рома Баранов on 09.05.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    // MARK: - IB Outlet
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoText: UITextView!
    
    // MARK: - Public Properties
    var hero: Hero!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var location: Location?
    
    // MARK: - View Life Sycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLocation()
        fetchImage()
    }
    override func viewDidLayoutSubviews() {
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func fetchLocation() {
        networkManager.fetch(Location.self, from: (hero.location.url ?? Link.firstHero.url.randomElement())!) { [weak self] result in
            switch result {
            case .success(let location):
                self?.location = location
                self?.updateInfoText()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchImage() {
        networkManager.fetchImage(from: hero.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.imageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateInfoText() {
        infoText.text = """
            Name: \(hero.name)
            Status: \(hero.status)
            Race: \(hero.species)
            Gender: \(hero.gender)
            
            
            LOCATION
            Name: \(location?.name ?? "")
            Type: \(location?.type ?? "")
            Dimension: \(location?.dimension ?? "")
            """
    }
}
