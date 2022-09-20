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

final class MapViewController: UIViewController, WKUIDelegate {
    private var webView: WKWebView!
    private var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "ischemes.ru"
        components.path = "/group/rtu-mirea/vern78"
        return components
    }()

  // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupWebView()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupWebView()
    }
  
  // MARK: View lifecycle
    
    override func loadView() {
        view = webView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("⭕️ viewDidLoad in MapViewController")
        makeRequest()
    }
}

    // MARK:  Webkit

private extension MapViewController {
    func setupWebView(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.underPageBackgroundColor = .white
        webView.scrollView.bounces = false
        webView.scrollView.minimumZoomScale = 2.5
        webView.scrollView.maximumZoomScale = 5.0
        webView.configuration.userContentController.addUserScript(disableZoom())
    }
    
    func makeRequest() {
        guard let url = self.components.url else { return }
        let myRequest = URLRequest(url: url)
        DispatchQueue.main.async {
            self.webView.load(myRequest)
        }
    }
    
    func disableZoom() -> WKUserScript {
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
