//
//  MapInteractor.swift
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

protocol MapBusinessLogic
{
  func doSomething(request: Map.Something.Request)
}

protocol MapDataStore
{
  //var name: String { get set }
}

class MapInteractor: MapBusinessLogic, MapDataStore
{
  var presenter: MapPresentationLogic?
  var worker: MapWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Map.Something.Request)
  {
    worker = MapWorker()
    worker?.doSomeWork()
    
    let response = Map.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
