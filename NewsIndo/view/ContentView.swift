//
//  ContentView.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import SwiftUI
import SafariServices

struct ContentView: View {
    @StateObject private var newsVM = NewsVM()
    @StateObject private var okenewsVM = OkeVM()
    @State private var isRedacted: Bool = true
    @State private var searchText: String = ""

    
    
    @State private var searchArticle: String = ""
    
    var articleSearchResults: [OkeArticle] {
        guard !searchArticle.isEmpty else {
            return okenewsVM.articles
        }
        return okenewsVM.articles.filter{
            $0.title.lowercased().contains(searchArticle.lowercased())
        }
    }
        
        var body: some View {
            NavigationStack {
                List(){
                    
                    if isRedacted {
                        ForEach(articleSearchResults){article in
                            HStack(){
                                AsyncImage(url: URL(string: article.image.small)){
                                    image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            placeholder: {
                                ZStack {
                                    WaitingView()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            }
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(article.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    Text(article.content)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    
                                    HStack {
                                        Text(article.isoDate.relativetoCurrentDate())
                                            .lineLimit(1)
                                        
                                        Button{
                                            let vc =  SFSafariViewController(url: URL(string: article.link)!)
                                            
                                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                                        }label: {
                                            Text("Selengkapnya")
                                                .lineLimit(1)
                                                .foregroundStyle(.pink)
                                            
                                        }
                                    }
                                }
                                
                                
                                
                                
                            }
                        }
                        .redacted(reason: .placeholder)
                    }
                    
                    else {
                        ForEach(articleSearchResults){article in
                            HStack(){
                                AsyncImage(url: URL(string: article.image.small)){
                                    image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            placeholder: {
                                ZStack {
                                    WaitingView()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                            }
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(article.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    Text(article.content)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                    
                                    HStack {
                                        Text(article.isoDate.relativetoCurrentDate())
                                            .lineLimit(1)
                                        
                                        Button{
                                            let vc =  SFSafariViewController(url: URL(string: article.link)!)
                                            
                                            UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                                        }label: {
                                            Text("Selengkapnya")
                                                .lineLimit(1)
                                                .foregroundStyle(.pink)
                                            
                                        }
                                    }
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                    
                }
                
                .refreshable {
                    isRedacted = true
                   
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isRedacted = false
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Constant.newsTitle)
                .task {
                    await okenewsVM.fetchNews()
                }
                .searchable(text: $searchArticle, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search News")
                
                .overlay(okenewsVM.isLoading ? ProgressView() : nil)
                
                .overlay{
                    if articleSearchResults.isEmpty{
                        ContentUnavailableView.search(text: searchText)
                        
                    }
                }
            }
        }
        
    }
    
    #Preview {
        ContentView()
    }
    
    
    
    @ViewBuilder
    func WaitingView() -> some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.pink)
            
            Text("Fetch Image......")
        }
    }
    
    extension UIApplication {
        var firstKeyWindow: UIWindow? {
            return UIApplication.shared.connectedScenes
                .compactMap { scene in scene as? UIWindowScene
                }
                .filter {filter in filter.activationState == .foregroundActive}
                .first?.keyWindow
        }
    }


