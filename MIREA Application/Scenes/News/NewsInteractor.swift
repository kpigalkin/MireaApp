//
//  NewsInteractor.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 04.08.2022.
//  Copyright (c) 2022 SenlaCourses. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsBusinessLogic {
    func getNewsFromServer(request: NewsModels.News.Request)
    func getNewsElement(request: NewsModels.NewsElement.Request)
}

protocol NewsDataStore {
    var page: Int { get set }
    var components: URLComponents { get set }
    var path: String { get }
}

final class NewsInteractor: NewsBusinessLogic, NewsDataStore, DecodeData {
    var page = 0
    var presenter: NewsPresentationLogic?
    let path: String = "/news"
    var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "tt-mosit.mirea.ru"
        return components
    }()
    
    func getNewsFromServer(request: NewsModels.News.Request) {
        print("⭕️ getNewsFromServer in NewsInteractor")
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(request.limit)),
            URLQueryItem(name: "page", value: String(page))
        ]
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            let news = self?.decode(NewsItems.self, from: data)
            guard let news = news else { return }
            DispatchQueue.main.async {
                let response = NewsModels.News.Response(items: news)
                self?.presenter?.presentNews(response: response)
                self?.page += 1
            }
        }
        task.resume()
    }

    func getNewsElement(request: NewsModels.NewsElement.Request) {
        print("⭕️ getNewsElement in NewsInteractor")
        components.path = path + "/" + String(request.id)
        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            let newsItem = self?.decode(NewsModels.NewsElement.Response.self, from: data)
            guard let newsItem = newsItem else { return }
            DispatchQueue.main.async {
                self?.presenter?.presentNewsElement(response: newsItem)
            }
        }
        task.resume()
    }
}
