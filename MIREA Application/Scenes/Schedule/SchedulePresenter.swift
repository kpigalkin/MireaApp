//
//  SchedulePresenter.swift
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

protocol SchedulePresentationLogic {
    func presentTeachersList(with response: ScheduleModels.Teachers.Response)
    func presentClasses(with response: ScheduleModels.Classes.Response)
}

final class SchedulePresenter: SchedulePresentationLogic {
    weak var viewController: ScheduleDisplayLogic?
  
    func presentTeachersList(with response: ScheduleModels.Teachers.Response) {
        let charset = CharacterSet(charactersIn: "а"..."я")
        let viewModel = response.filter { item in
            item.name.rangeOfCharacter(from: charset) != nil
        }
        viewController?.routeToPersonSettings(viewModel: viewModel)
    }
    
    func presentClasses(with response: ScheduleModels.Classes.Response) {
        // Не забыть добавить условие в алгоритм parity
        
        //        print("weekDay for array adress \(response.dayInfo.weekDay), items count = \(response.dayClasses.count)")
        let isEven = response.dayInfo.weekNumber % 2 == 0

        let weekdayClasses = response.dayClasses[response.dayInfo.weekDay - 1]
        var viewModel = ScheduleModels.Classes.ViewModel()

        switch isEven {
        case true:
            weekdayClasses.forEach { employment in
                employment.value.even.forEach { subject in
                    if subject.weeks.contains(response.dayInfo.weekNumber) {
                        // Items mustn't overlap anyway so only one will add
                        viewModel.append(subject)
                    }
                }
            }
        case false:
            weekdayClasses.forEach { employment in
                employment.value.odd.forEach { subject in
                    if subject.weeks.contains(response.dayInfo.weekNumber) {
                        // Items mustn't overlap anyway so only one will add
                        viewModel.append(subject)
                    }
                }
            }
        }
        // sort
        
        
        viewModel = viewModel.sorted {
            $0.number < $1.number
        }
        viewController?.displayDayClasses(viewModel: viewModel)
    }
}
