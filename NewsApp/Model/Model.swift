//
//  Model.swift
//  NewsApp
//
//  Created by Вячеслав Кремнев on 18.09.2022.
//

import Foundation


// MARK: - News
struct News: Codable {
    let status: String
    let news: [NewsElement]
    
//    init?(json: [String: Any]) {
//        guard let status = json["status"] as? String,
//              let news = json["news"] as? [NewsElement]
//        else {
//            return nil
//        }
//        self.status = status
//        self.news = news
//    }
}

// MARK: - NewsElements
struct NewsElement: Codable {
    let id: String
    let title: String
    let newsDescription: String
    let url: String
    let author: String
    let image: String
    let language: String
    let category: [String]
    
//    init?(json: [String: Any]) {
//  guard let id = json["id"] as? String,
//        let title = json["title"] as? String,
//        let newsDescription = json["newsDescription"] as? String,
//        let url = json["url"] as? String,
//        let author = json["author"] as? String,
//        let image = json["image"] as? String,
//        let language = json["image"] as? String,
//        let category = json["category"] as? [String]
//        else {
//            return nil
//        }
//        
//        self.id = id
//        self.title = title
//        self.newsDescription = newsDescription
//        self.url = url
//        self.author = author
//        self.image = image
//        self.language = language
//        self.category = category
//    }
    
    

    enum CodingKeys: String, CodingKey {
        case id, title
        case newsDescription = "description"
        case url, author, image, language, category
    }
}


