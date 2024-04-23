//
//  OKEAPIService.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation
import Alamofire


class OKEAPIService{
    
    static let shared = OKEAPIService()
    private init() {
        
    }


    func fetchOkeNews() async throws -> [OkeArticle]{
        guard let url = URL(string: Constant.OkenewsURL) else { throw
            URLError(.badURL)}
        
        let okenews = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: OkeNews.self) { response in
                switch response.result {
                case .success(let okenewsResponse):
                    continuation.resume(returning: okenewsResponse.data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        
        return okenews
    }
    
    
    
}

