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
    
    let session: URLSession = {
        let session = URLSession(configuration: .default)
        session.configuration.timeoutIntervalForRequest = 30
        return session
    }()
    
    func fetchData(_ url: String, completion: @escaping(Result<News, ErrorType>) -> Void) {
        
        guard let url = URL(string: url) else {completion(.failure(ErrorType.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(API.token.rawValue, forHTTPHeaderField: "Authorization")
        
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            //слабая ссылка во избежание цикла, а сильная гарантирует чтоб блок завершится а затем после выхода из блока она обнулится
            guard let strongSelf = self else {return}
            print(strongSelf)
            
            
            if let error = error {
                print(error)
                return completion(.failure(.invalidURL))
            }
            
            guard let data = data else {
                return completion(.failure(.noDataAvailable))
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            do {
                let model = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                completion(.failure(ErrorType.parsingError))
            }
        }
        task.resume()
    }
   
}

class ImageManager {
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void){
        //сессия для того чтобы получить объект + ответ от сервера для кеширования изображения
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            //так же сравним url адрес изображения запрошенного из ячейки с адресом изображения которое нам вернулось(только в случае соответствия присваиваем данные) - блоки замыкания работают асинхронно а сам запрос совершается моментально
            guard url == response.url else {return}
            
            DispatchQueue.global().async {
                completion(data, response)
            }
        }.resume()
    }
}


enum Link: String {
    case requestURL = "https://api.currentsapi.services/v1/latest-news"
}

enum ErrorType: Error {
    case invalidURL
    case noDataAvailable
    case parsingError
}

enum API: String {
    case token = "CBlnbESdR94V-al0LkiymAWTL3CyF_BV7n9_HZZ58uPrtB3F"
}
