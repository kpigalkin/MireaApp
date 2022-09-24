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
        label.textColor = Color.defaultTheme.dirtyWhite
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let groupTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Color.defaultTheme.dirtyWhite.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let classroomTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Color.defaultTheme.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        return label
    }()
    
    private let classTypeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Color.defaultTheme.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        label.layer.masksToBounds = true
        return label
    }()
    
    private let timeTitle: UILabel = {
        let label = UILabel()
        label.textColor = Color.defaultTheme.dirtyWhite
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .monospacedSystemFont(ofSize: 13, weight: .semibold)
        label.layer.cornerRadius = Const.lowSizeCorner
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
        classTypeTitle.backgroundColor = setColorByTypeOfClass(type: content.type)
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
            classroomTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.space),
            classroomTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            classroomTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            classTypeTitle.trailingAnchor.constraint(equalTo: classroomTitle.trailingAnchor),
            classTypeTitle.topAnchor.constraint(equalTo: topAnchor, constant: Const.middleSpace),
            classTypeTitle.widthAnchor.constraint(equalTo: classroomTitle.widthAnchor),
            classTypeTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.27),

            classNameTitle.topAnchor.constraint(equalTo: topAnchor, constant: Const.middleSpace),
            classNameTitle.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor, constant: 7),
            classNameTitle.trailingAnchor.constraint(equalTo: classTypeTitle.leadingAnchor, constant: -7),
            
            groupTitle.leadingAnchor.constraint(equalTo: classNameTitle.leadingAnchor),
            groupTitle.trailingAnchor.constraint(equalTo: classNameTitle.trailingAnchor),
            groupTitle.topAnchor.constraint(equalTo: classNameTitle.bottomAnchor, constant: 30),
            groupTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Const.space),
        ])
    }
    
    private func setupView() {
        self.layer.cornerRadius = Const.lowSizeCorner
        self.layer.masksToBounds = true
        backgroundColor = Color.defaultTheme.lightBlack
    }
}

private extension ListContentView {
    func setClassTime(for classNumber: Int) -> String {
        switch classNumber {
        case 1:
            return "9:00" + "\n" + "10:30"
        case 2:
            return "10:40" + "\n" + "12:10"
        case 3:
            return "12:40" + "\n" + "14:10"
        case 4:
            return "14:20" + "\n" + "15:50"
        case 5:
            return "16:20" + "\n" + "17:50"
        case 6:
            return "18:00" + "\n" + "19:30"
        case 7:
            return "19:40" + "\n" + "21:10"
        default:
            return ""
        }
    }
    
    func setColorByTypeOfClass(type: String) -> UIColor {
        switch type.uppercased() {
        case "ЛК":
            return .lightGray
        case "ПР":
            return Color.defaultTheme.red.withAlphaComponent(0.93)
        case "ЛАБ":
            return Color.defaultTheme.lightBlack
        default:
            return .black
        }
    }
}
