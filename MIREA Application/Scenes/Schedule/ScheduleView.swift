//
//  ScheduleView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 26.08.2022.
//

import UIKit
import Foundation

class CalendarCell: UICollectionViewCell {
    var id : Int?
    var month: String?
    var day: Int?
    var weekNumber: Int?
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.08) { // for animation effect
                    self.backgroundColor = Colors.defaultTheme.darkBlue
                }
            }
            else {
                UIView.animate(withDuration: 0.2) { // for animation effect
                    self.backgroundColor = .clear
                }
            }
        }
    }
}

final class ScheduleView: UIView, UICollectionViewDelegate {
    
    weak var scheduleVCDelegate: ScheduleVСDelegate?
    
        // MARK: Registration
    
    private let weekDayCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, WeekDayConfiguration> { cell, indexPath, itemConfiguration in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemConfiguration
    }
    
    private let calendarCellRegistration = UICollectionView.CellRegistration<CalendarCell, CalendarConfiguration> { cell, indexPath, itemConfiguration in
        cell.contentConfiguration = nil
        cell.id = itemConfiguration.id
        cell.month = itemConfiguration.month
        cell.day = itemConfiguration.day
        cell.weekNumber = itemConfiguration.weekNumber
        cell.contentConfiguration = itemConfiguration
    }
    
    private let listCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ListConfiguration> { cell, indexPath, itemConfiguration in
        cell.contentConfiguration = nil
        cell.contentConfiguration = itemConfiguration
    }
    
    override init(frame: CGRect) {
        print("⭕️ init in ScheduleView")
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        makeSnapshot()
        
        appendCalendarItems()
        appendWeekDaysItems()
    }
    
        // MARK: - UICollectionView
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: ScheduleCollectionViewLayoutFactory.scheduleFeedLayout())
        view.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    private lazy var dataSourse = makeDataSourse()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ScheduleSection, ScheduleCollectionItem>()
        snapshot.appendSections([.weekDays ,.calendar, .list])
        dataSourse.apply(snapshot)
    }
    
    private func makeDataSourse() -> UICollectionViewDiffableDataSource<ScheduleSection, ScheduleCollectionItem> {
        let dataSourse = UICollectionViewDiffableDataSource<ScheduleSection, ScheduleCollectionItem>(collectionView: collectionView) { [weak self] collectionView,
            indexPath, item in
            guard let self = self,
                  let _ = self.dataSourse.sectionIdentifier(for: indexPath.section) else {
                return .init(frame: .zero)
            }
            switch item.content {
            case .weekDay(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.weekDayCellRegistration, for: indexPath, item: configuration)
            case .calendar(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.calendarCellRegistration, for: indexPath, item: configuration)
            case .list(configuration: let configuration):
                return collectionView.dequeueConfiguredReusableCell(using: self.listCellRegistration, for: indexPath, item: configuration)
            }
        }
        return dataSourse
    }
    
    private func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 1 {return} // Clickable calendar only
        guard let _ = UserDefaults.standard.value(forKey: UDKeys.id) else {
            print("Choose teacher")
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as? CalendarCell
//        print("🙋🏻‍♂️🗒 cell: indexPath \(indexPath), id: \(cell?.id), month: \(cell?.month), day: \(cell?.day), weekNumber: \(cell?.weekNumber)")
        
        let weekDay = CalendarHelper.getWeekDay(month: cell?.month, day: cell?.day)
        guard weekDay != 7  else {
            print("Воскресенье")
            return
        }
                
        scheduleVCDelegate?.getClassesForSpecificDay(weekDay: weekDay, weekNumber: cell?.weekNumber ?? 1)
    }
    
    // MARK: - Filling data
    
    private func appendCalendarItems() {
        // Сreate an array of calendar days that contains [42 * number of months] days.
        //                                                      42 = 6 rows by 7 columns.
        // So, sometimes some days are duplicated at the beginning and end of the months.
        
                // Array for number of days & id-counter & weekCounter & adjustment for weekNumber
        var calendar = [ScheduleCollectionItem]()
        var counter = (id: 0, cellCount: 1, nextMonthDays: 1)
        var week = (number: 1, adjustment: 0)

        var date = CalendarHelper.dropMonth(date: CalendarHelper.getCurrentDate(), monthNumber: "09")
        
        repeat {
            let dateMarks = CalendarHelper.makeDateMarks(date: date)
            counter.cellCount = 1
            counter.nextMonthDays = 1
            
            while counter.cellCount <= 42 {
                week.number = counter.id / 7 + 1 - week.adjustment

                if counter.cellCount < dateMarks.startSpace {
                    
                // Days of previous month
                    calendar.append(ScheduleCollectionItem(content: .calendar(configuration: .init(
                        id: counter.id,
                        day: dateMarks.daysInPreviousMonth - dateMarks.startSpace + 1 + counter.cellCount,
                        month: CalendarHelper.monthStringNumber(date: CalendarHelper.minusMonth(date: date)),
                        isCurrent: false,
                        weekNumber: week.number))))
                } else if counter.cellCount - dateMarks.startSpace >= dateMarks.daysInMonth {
                    
                // Days in next month, started from 1
                    calendar.append(ScheduleCollectionItem(content: .calendar(configuration: .init(
                        id: counter.id,
                        day: counter.nextMonthDays,
                        month: CalendarHelper.monthStringNumber(date: CalendarHelper.plusMonth(date: date)),
                        isCurrent: false,
                        weekNumber: week.number))))
                    counter.nextMonthDays += 1
                } else {
                    
                // Days in current(selected) month
                    calendar.append(ScheduleCollectionItem(content: .calendar(configuration: .init(
                        id: counter.id,
                        day: counter.cellCount - dateMarks.startSpace + 1,
                        month: dateMarks.currentMonthStringNumber,
                        isCurrent: true,
                        weekNumber: week.number))))
                }
                counter.id += 1
                counter.cellCount += 1
            }
            week.adjustment += CalendarHelper.weekAdjustment(previousMonthDays: dateMarks.startSpace, currentMonthDays: dateMarks.daysInMonth)
            date = CalendarHelper.plusMonth(date: date)
            
        } while CalendarHelper.monthStringNumber(date: date) != "01"
    
        var snapshot = dataSourse.snapshot()
        snapshot.appendItems(calendar, toSection: .calendar)
        dataSourse.apply(snapshot)
    }
    private func appendWeekDaysItems() {
                // Fill weekDays section
        let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        var weekDays = [ScheduleCollectionItem]()
        days.forEach { day in
            let index = days.firstIndex(of: day)
            let item = ScheduleCollectionItem(content: .weekDay(configuration: .init(id: index ?? 0, day: day)))
            weekDays.append(item)
        }
        
        var snapshot = dataSourse.snapshot()
        snapshot.appendItems(weekDays, toSection: .weekDays)
        dataSourse.apply(snapshot)
    }
}

extension ScheduleView: ScheduleViewDelegate {
    func showClasses(_ viewModel: ScheduleModels.Classes.ViewModel) {
        print("⭕️ showClasses in ScheduleView")
        var classesList = [ScheduleCollectionItem]()
        var idCounter = 0
        viewModel.forEach { item in
            let classElement = ScheduleCollectionItem(content: .list(configuration: .init(
                id: idCounter, name: item.name, room: item.room,
                type: item.type, group: item.group, number: item.number, wdNum: item.wdNum)))
            classesList.append(classElement)
            idCounter += 1
        }
        
        var snapshot = dataSourse.snapshot(for: .list)
        snapshot.deleteAll()
        snapshot.append(classesList)
        dataSourse.apply(snapshot, to: .list, animatingDifferences: false)

        if classesList.count != 0 {
            collectionView.scrollToItem(at: [2, classesList.count - 1], at: .centeredVertically, animated: true)
        }
    }
}

protocol ScheduleViewDelegate: AnyObject {
    func showClasses(_ viewModel: ScheduleModels.Classes.ViewModel)
}
    
