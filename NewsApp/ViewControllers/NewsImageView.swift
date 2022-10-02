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
        
        //используем изображение из кеша если оно там есть
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            //если не выйти из метода то пойдет обращение к сетевому менеджеру(если нашли изображение в кеше то в сеть идти не нужно)
            return
        }
        
        //если нет идем в сеть - сперва грузим из сети
        ImageManager.shared.fetchImage(from: url) { data, response in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        //сохраним в кеш
        guard let url = response.url else {return}
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data) //кешируемый объект(data + response)
        //request - помещаем запрос по которому в дальнейшем будем искать данный объект
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        //создадим запрос для поиска в кеше
        let request = URLRequest(url: url)
        //теперь необходимо найти сохраненный до этого в кеш объект - cachedResponse
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
}


