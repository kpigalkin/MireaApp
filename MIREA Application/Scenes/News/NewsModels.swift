//
//  NewsModels.swift
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

enum NewsModels
{
  // MARK: Use cases
  
  enum News {
      
    struct Request {
        let path: String
    }
      
    struct ResponseItem: Decodable {
        let id: Int
        let name: String
        let image: String
    }
    typealias Response = [ResponseItem]
      
    struct ViewModel {
        let element: [NewsCollectionItem]
        
        // added init for "_ .." in call
        init(_ news: [NewsCollectionItem]) {
            self.element = news  
        }
    }
  }
    
    enum SpecificNews {
        struct Request {
            let id: Int
        }
        struct Response: Codable {
            let id: Int
            let title, date, text: String
            let image: String
            let url: String
        }
        struct ViewModel {
            let id: Int
            let title, date, text: String
            let image: String
            let url: String
        }
    }
}
