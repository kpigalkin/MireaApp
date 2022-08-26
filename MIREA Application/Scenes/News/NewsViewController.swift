//
//  NewsViewController.swift
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


protocol NewsViewControllerDelegate: AnyObject {
    func userSelectedCell(indexPath: IndexPath, id: Int)
}

protocol NewsDisplayLogic: AnyObject {
  func displayNews(viewModel: NewsModels.News.ViewModel)
  func displaySpecificNews(viewModel: NewsModels.SpecificNews.ViewModel)
}

final class NewsViewController: UIViewController, NewsDisplayLogic {
    var interactor: NewsBusinessLogic?
    var router: (NSObjectProtocol & NewsRoutingLogic & NewsDataPassing)?
    weak var newsViewDelegate: NewsViewDelegate?
    var newsView = NewsView()

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    print("⭕️ init in NewsViewController")
      
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = NewsInteractor()
    let presenter = NewsPresenter()
    let router = NewsRouter()
//    let worker = NewsWorker()

    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
//    interactor.worker = worker
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
    
    newsView.newsViewControllerDelegate = self
    newsViewDelegate = newsView
    navigationItem.title = "News"

  }
  
  // MARK: Routing
  
  // MARK: View lifecycle
    
    override func loadView() {
        print("⭕️ loadView in NewsViewController")
        view = newsView
        makeRequest()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colorTop = Colors.defaultTheme.sand.cgColor
        let colorBottom = Colors.defaultTheme.darkBlue.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.2, 1.15]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
  // MARK: Do something
    
    func makeRequest() {
        print("⭕️ makingRequest in NewsViewController")
        let request = NewsModels.News.Request(path: "/news")
        interactor?.getNewsFromServer(request: request)
    }
  
    func displayNews(viewModel: NewsModels.News.ViewModel) {
        print("⭕️ displayNews in NewsViewController")
        newsViewDelegate?.showNews(viewModel)
    }
    
    func displaySpecificNews(viewModel: NewsModels.SpecificNews.ViewModel) {
        print("⭕️ displaySpecificNews in NewsViewController")
        self.router?.displaySpecificNews(viewModel: viewModel)
    }

}

extension NewsViewController: NewsViewControllerDelegate {
    func userSelectedCell(indexPath: IndexPath, id: Int) {
        print("⭕️ userSelectedCell in NewsViewController")
        let request = NewsModels.SpecificNews.Request.init(id: id)
        interactor?.getSpecificNews(request: request)
    }
}

