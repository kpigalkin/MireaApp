//
//  PersonViewController.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 31.08.2022.
//

import UIKit
import Foundation



final class PersonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teachers: ScheduleModels.Teachers.ViewModel
    
    private let personTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Colors.defaultTheme.dirtyWhite
        label.textAlignment = .center
        label.text = UserDefaults.standard.string(forKey: UDKeys.name)
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(PersonCell.self, forCellReuseIdentifier: "tableCell")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
        // MARK: Lifecycle

    init(teachers: ScheduleModels.Teachers.ViewModel) {
        self.teachers = teachers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        scrollToSelectedTeacher(key: UDKeys.name)
    }
    
        // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let teacher = teachers[indexPath.item]
        let cell: PersonCell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! PersonCell
        cell.id = teacher.id
        cell.name = teacher.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PersonCell
        personTitle.text = cell.name
        UserDefaults.standard.set(cell.id, forKey: UDKeys.id)
        UserDefaults.standard.set(cell.name, forKey: UDKeys.name)
    }
    
}

        // MARK: - Setup

extension PersonViewController {
    func setup() {
        view.backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.95)
        addSubviews()
        makeConstraints()
    }
    
    func addSubviews() {
        view.addSubview(personTitle)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        personTitle.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            personTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: personTitle.bottomAnchor, constant: Constants.heightPadding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func scrollToSelectedTeacher(key: String) {
        var adress: Int?
        if let teacherName = UserDefaults.standard.value(forKey: key) {
            adress = teachers.firstIndex { item in
                item.name == teacherName as! String
            }
        }
        tableView.scrollToRow(at: [0, adress ?? 0], at: .top, animated: true)
        tableView.selectRow(at: [0, adress ?? 0], animated: true, scrollPosition: .top)
    }
}

// MARK: - Custom cell

final class PersonCell: UITableViewCell {

    var id: Int?
    var name: String?

    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)

        var contentConfig = defaultContentConfiguration().updated(for: state)
        contentConfig.text = name
        contentConfig.textProperties.color = .white

        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        backgroundConfig?.backgroundColor = .clear

        if state.isHighlighted || state.isSelected {
            backgroundConfig?.backgroundColor = Colors.defaultTheme.red
            contentConfig.textProperties.color = .white
        }

        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
}
