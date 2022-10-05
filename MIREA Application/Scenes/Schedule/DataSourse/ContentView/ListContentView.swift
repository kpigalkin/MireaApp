//
//  ListContentView.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 27.08.2022.
//

import UIKit

final class ListContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration

    private let classNameTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textColor = Color.defaultDark.dirtyWhite
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let groupTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Color.defaultDark.dirtyWhite.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let classroomTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Color.defaultDark.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        return label
    }()
    
    private let classTypeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Color.defaultDark.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        label.layer.masksToBounds = true
        return label
    }()
    
    private let timeTitle: UILabel = {
        let label = UILabel()
        label.textColor = Color.defaultDark.dirtyWhite
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .monospacedSystemFont(ofSize: 13, weight: .semibold)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    init(with contentConfiguration: ListConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        setupView()
        configure()
        addSubviews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? ListConfiguration else { return }
        classNameTitle.text = content.name
        classTypeTitle.text = content.type.uppercased()
        classTypeTitle.backgroundColor = determColor(type: content.type)
        groupTitle.text = content.group
        classroomTitle.text = content.room
        timeTitle.text = setClassTime(for: content.number)
    }
    
    private func addSubviews() {
        addSubview(classNameTitle)
        addSubview(groupTitle)
        addSubview(classroomTitle)
        addSubview(timeTitle)
        addSubview(classTypeTitle)
    }

    private func makeConstraints() {
        classNameTitle.translatesAutoresizingMaskIntoConstraints = false
        groupTitle.translatesAutoresizingMaskIntoConstraints = false
        classroomTitle.translatesAutoresizingMaskIntoConstraints = false
        timeTitle.translatesAutoresizingMaskIntoConstraints = false
        classTypeTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeTitle.topAnchor.constraint(equalTo: topAnchor),
            timeTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            timeTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            
            classroomTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            classroomTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            classroomTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            classroomTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            classTypeTitle.trailingAnchor.constraint(equalTo: classroomTitle.trailingAnchor),
            classTypeTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            classTypeTitle.widthAnchor.constraint(equalTo: classroomTitle.widthAnchor),
            classTypeTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.27),

            classNameTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            classNameTitle.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor, constant: 7),
            classNameTitle.trailingAnchor.constraint(equalTo: classTypeTitle.leadingAnchor, constant: -7),
            
            groupTitle.leadingAnchor.constraint(equalTo: classNameTitle.leadingAnchor),
            groupTitle.trailingAnchor.constraint(equalTo: classNameTitle.trailingAnchor),
            groupTitle.topAnchor.constraint(equalTo: classNameTitle.bottomAnchor, constant: 30),
            groupTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        backgroundColor = Color.defaultDark.lightBlack
    }
}

private extension ListContentView {
    func setClassTime(for classNumber: Int) -> String {
        let item = ClassTime.allCases[classNumber - 1]
        return item.rawValue
    }
    
    func determColor(type: String) -> UIColor {
        switch type.uppercased() {
        case "ЛК":
            return Color.lection
        case "ПР":
            return Color.practice
        case "ЛАБ":
            return Color.labaratory
        default:
            return Color.defaultColor
        }
    }
    
    enum ClassTime: String, CaseIterable {
        case first = "9:00\n10:30"
        case second = "10:40\n12:10"
        case third = "12:40\n14:10"
        case fourth = "14:20\n15:50"
        case fifth = "16:20\n17:50"
        case sixth = "18:00\n19:30"
        case seventh = "19:40\n21:10"
    }
}
