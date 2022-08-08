//
//  ScheduleInteractor.swift
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

protocol ScheduleBusinessLogic
{
  func doSomething(request: Schedule.Something.Request)
}

protocol ScheduleDataStore
{
  //var name: String { get set }
}

class ScheduleInteractor: ScheduleBusinessLogic, ScheduleDataStore
{
  var presenter: SchedulePresentationLogic?
  var worker: ScheduleWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Schedule.Something.Request)
  {
    worker = ScheduleWorker()
    worker?.doSomeWork()
    
    let response = Schedule.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
