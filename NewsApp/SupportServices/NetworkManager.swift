//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 18.09.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(_ url: String, completion: @escaping(News) -> Void) {
        
        guard let url = URL(string: url) else {return}
        
        var request = URLRequest(url: url)
        request.addValue(API.token.rawValue, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription as Any)
                return
            }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    completion(news)
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
}



//MARK: Image Manager
class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else {return}
            
            DispatchQueue.global().async {
                completion(data, response)
            }
        }.resume()
    }
}

//MARK: API Link
enum Link: String {
    case requestURL = "https://api.currentsapi.services/v1/latest-news"
}

////MARK: Error Cases
//enum ErrorType: Error {
//    case invalidURL
//    case noDataAvailable
//    case parsingError
//}

//MARK: API Token
enum API: String {
    case token = "CBlnbESdR94V-al0LkiymAWTL3CyF_BV7n9_HZZ58uPrtB3F"
}
