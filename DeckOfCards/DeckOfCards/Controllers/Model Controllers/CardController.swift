//
//  CardController.swift
//  DeckOfCards
//
//  Created by Nicholas Towery on 11/17/20.
//

import Foundation
import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")
    static let drawComponent = "new/draw/"
    static let cardCountExtension = "count=1"

    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        
        // 1 - Prepare URL
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let componentURL = baseURL.appendingPathComponent(drawComponent)
        var components = URLComponents(url: componentURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "count", value: "1")]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)

        
        // 2 - Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error{
                print("There was an error")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                // 4 - Check for json data
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                // 5 - Decode json into a Card
                guard let card = topLevelObject.cards.first else {return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                return completion(.failure(.noData))
            }
        } .resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void){
        // 1 - Prepare URL
        let url = card.image
        // 2 - Contact server
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print("There was an error")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            // 4 - Check for image data
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            // 5 - Initialize an image from the data
            return completion(.success(image))
        } .resume()
      
    }
    
} // End of class
