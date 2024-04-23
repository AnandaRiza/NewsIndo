//
//  NewsOke.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

// MARK: - Welcome
struct OkeNews: Codable {
    let message: String
    let total: Int
    let data: [OkeArticle]
}

// MARK: - Datum
struct OkeArticle: Codable, Identifiable {
    var id: String {link}
    let title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: OkeImage
}


// MARK: - Image
struct OkeImage: Codable {
    let small, medium, large: String
}
