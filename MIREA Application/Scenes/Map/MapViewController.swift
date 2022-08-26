//
//  MapViewController.swift
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
import WebKit

protocol MapDisplayLogic: AnyObject
{
  func displaySomething(viewModel: Map.Something.ViewModel)
}

final class MapViewController: UIViewController, MapDisplayLogic, WKUIDelegate
{
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    var webView: WKWebView!

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
    private func setup(){
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
    
    override func loadView() {
        super.loadView()
        setupWebView()
    }
  
  override func viewDidLoad()
  {
    print("⭕️ viewDidLoad in MapViewController")
      
    super.viewDidLoad()
    doSomething()
    loadRequest()
  }
//    override func viewWillAppear(_ animated: Bool) {
//        openMireaMap()
//    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething() {
    let request = Map.Something.Request()
    interactor?.doSomething(request: request)
  }
    
//    func openMireaMap() {
//        if let url = URL(string: "https://ischemes.ru/group/rtu-mirea/vern78") {
//             if UIApplication.shared.canOpenURL(url) {
//                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
//             }
//         }
//    }
  
  func displaySomething(viewModel: Map.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}

// Webkit
private extension MapViewController {
    
    func setupWebView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.underPageBackgroundColor = .white
        webView.scrollView.bounces = false
        
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 5.0
        webView.configuration.userContentController.addUserScript(getZoomDisableScript())
        
        view = webView
    }
    
    func loadRequest() {
        let myURL = URL(string:"https://ischemes.ru/group/rtu-mirea/vern78")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func getZooomDisableScript() -> WKUserScript {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);"
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    func getZoomDisableScript() -> WKUserScript {
        let source: String = """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum- scale=1.0, user-scalable=no';
            var head = document.getElementsByTagName('head')[0];
            head.appendChild(meta);
        """
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
}

