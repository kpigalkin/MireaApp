//
//  NewsInteractor.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 04.08.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsBusinessLogic {
    func getResponseFromMireaServer(request: NewsModels.News.Request)
}

protocol NewsDataStore
{
  //var name: String { get set }
}

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    
  var presenter: NewsPresentationLogic?
  var worker: NewsWorker?
  let domain = "https://tt-mosit.mirea.ru"
  
  // MARK: Do something
  
    func getResponseFromMireaServer(request: NewsModels.News.Request) {
        print("⭕️ getResponseFromMireaServer in NewsViewController")
        
        let url = URL(string: domain + request.path)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let news = try? JSONDecoder().decode(NewsModels.News.Response.self, from: data) {
                self.presenter?.presentNews(response: news)
            }
        }
        task.resume()
  }
}
