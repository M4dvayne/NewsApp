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

//MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case id, title
        case newsDescription = "description"
        case url, author, image, language, category
    }
}


