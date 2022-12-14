//
//  NewsImageView.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 29.09.2022.
//

import UIKit

class NewsImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = UIImage(systemName: "square")
            return
        }
        
        //MARK: Fetch Image From Cache
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        //MARK: Fetch Image From Network
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    //MARK: Save Image To Cache
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else {return}
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    //MARK: Get Cached Image
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}


