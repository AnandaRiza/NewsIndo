//
//  OkeVM.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

@MainActor
class OkeVM: ObservableObject{
    @Published var articles = [OkeArticle]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        errorMessage = nil
        
        do{
            articles = try await OKEAPIService.shared.fetchOkeNews()
            isLoading = false
            
        }catch{
            errorMessage = "🙅‍♀️ \(error.localizedDescription). Failed to fetch News from API 🙅‍♀️ "
            print(errorMessage ?? "N/A")
            isLoading = false
        }
    }
}
