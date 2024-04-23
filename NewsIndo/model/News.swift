//
//  News.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation


// MARK: - Welcome
struct News: Codable {
    let messages: String
    let total: Int
    let data: [NewsArticle]
}

// MARK: - Datum
struct NewsArticle: Identifiable, Codable {
    var id: String {link}
    let creator, title: String
    let link: String
    let author: String
    let categories: [String]
    let isoDate, description: String
    let image: Image
}

// MARK: - Image
struct Image: Codable {
    let small, medium, large, extraLarge: String
}
