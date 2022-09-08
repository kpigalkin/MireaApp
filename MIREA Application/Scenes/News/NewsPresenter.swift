//
//  NewsPresenter.swift
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

protocol NewsPresentationLogic {
    func presentNews(response: NewsModels.News.Response)
    func presentSpecificNews(response: NewsModels.SpecificNews.Response)
}

final class NewsPresenter: NewsPresentationLogic {
    
  weak var viewController: NewsDisplayLogic?

  // MARK: Do something
  
    func presentNews(response: NewsModels.News.Response) {
        print("⭕️ presentNews in NewsPresenter")
        let defaultImageUrl = URL(string: "https://www.mirea.ru/upload/medialibrary/d07/RTS_colour.jpg")
        var news = [NewsCollectionItem]()
        for item in response {
            let url = URL(string: item.image) ?? defaultImageUrl
            let element = NewsCollectionItem(content: .news(config: .init(
                id: item.id,
                name: item.name,
                imageUrl: url!,
                image: nil
            )))
            news.append(element)
      }
      
      let viewModel = NewsModels.News.ViewModel(news)
      viewController?.displayNews(viewModel: viewModel)
  }
    func presentSpecificNews(response: NewsModels.SpecificNews.Response) {
        print("⭕️ presentSpecificNews in NewsPresenter")

        let viewModel = NewsModels.SpecificNews.ViewModel.init(
            id: response.id,
            title: response.title,
            date: response.date,
            text: response.text,
            image: response.image,
            url: response.url
        )
        viewController?.displaySpecificNews(viewModel: viewModel)        
    }
}

