//
//  MapPresenter.swift
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

protocol MapPresentationLogic
{
  func presentSomething(response: Map.Something.Response)
}

class MapPresenter: MapPresentationLogic
{
  weak var viewController: MapDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Map.Something.Response)
  {
    let viewModel = Map.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
