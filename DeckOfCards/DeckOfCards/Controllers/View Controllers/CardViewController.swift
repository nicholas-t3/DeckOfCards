//
//  CardViewController.swift
//  DeckOfCards
//
//  Created by Nicholas Towery on 11/17/20.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    // MARK: - Actions
    
    func fetchImageAndUpdateViews(for card: Card){
        CardController.fetchImage(for: card) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case.success(let image):
                    self?.cardImage.image = image
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                case.failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
              switch result {
              case .success(let card):
                  self?.fetchImageAndUpdateViews(for: card)

                case .failure(let error):
                  self?.presentErrorToUser(localizedError: error)
              }
            }
         
    }
}
}
