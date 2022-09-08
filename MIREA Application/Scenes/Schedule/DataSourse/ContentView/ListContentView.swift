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
        label.textColor = Colors.defaultTheme.dirtyWhite
        label.textAlignment = .left
//        label.layer.backgroundColor =
        label.numberOfLines = 0
        return label
    }()
    
    private let groupTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Colors.defaultTheme.dirtyWhite.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let classroomTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Colors.defaultTheme.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let classTypeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = Colors.defaultTheme.dirtyWhite.withAlphaComponent(0.85)
        label.textAlignment = .center
        label.backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.8)

        label.numberOfLines = 0
        return label
    }()
    
    private let timeTitle: UILabel = {
        let label = UILabel()
//        label.font = .systemFont(ofSize: 13, weight: .heavy)
        label.textColor = Colors.defaultTheme.dirtyWhite
        label.backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .monospacedSystemFont(ofSize: 13, weight: .bold)
        return label
    }()

    init(with contentConfiguration: ListConfiguration) {
        configuration = contentConfiguration
        super.init(frame: .zero)
        addSubviews()
        configure()
        makeConstraints()
        setupLayers()
        backgroundColor = Colors.defaultTheme.darkBlue.withAlphaComponent(0.6)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        guard let content = configuration as? ListConfiguration else {
            return
        }
        classNameTitle.text = content.name
        classTypeTitle.text = content.type.uppercased()
        groupTitle.text = content.group
        classroomTitle.text = content.room
        timeTitle.text = setClassTime(for: content.number)
        
        classTypeTitle.backgroundColor = setColorByTypeOfClass(type: content.type)
//        print("✄ cellConfigured")
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
            timeTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            classroomTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            classroomTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            classroomTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15),
            classroomTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            
            classTypeTitle.trailingAnchor.constraint(equalTo: classroomTitle.trailingAnchor),
            classTypeTitle.topAnchor.constraint(equalTo: topAnchor, constant: Constants.heightPadding),
//            classTypeTitle.bottomAnchor.constraint(equalTo: classroomTitle.topAnchor),
            classTypeTitle.widthAnchor.constraint(equalTo: classroomTitle.widthAnchor),
            classTypeTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),

            
            classNameTitle.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            classNameTitle.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor, constant: 7),
            classNameTitle.trailingAnchor.constraint(equalTo: classTypeTitle.leadingAnchor, constant: -7),
            
            groupTitle.leadingAnchor.constraint(equalTo: classNameTitle.leadingAnchor),
            groupTitle.trailingAnchor.constraint(equalTo: classNameTitle.trailingAnchor),
            groupTitle.topAnchor.constraint(equalTo: classNameTitle.bottomAnchor, constant: 30),
            groupTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding)
        ])
    }
    /*
     classNameTitle.topAnchor.constraint(equalTo: topAnchor),
     classNameTitle.leadingAnchor.constraint(equalTo: timeTitle.trailingAnchor, constant: 7),
     classNameTitle.trailingAnchor.constraint(equalTo: classTypeTitle.leadingAnchor, constant: -7),
     classNameTitle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.55),//
     
     groupTitle.leadingAnchor.constraint(equalTo: classNameTitle.leadingAnchor),
     groupTitle.trailingAnchor.constraint(equalTo: classNameTitle.trailingAnchor),
     groupTitle.topAnchor.constraint(equalTo: classNameTitle.bottomAnchor, constant: Constants.padding),
     groupTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding)
     */
    
    private func setupLayers() {
        layer.cornerRadius = 17
        layer.masksToBounds = true
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowColor = UIColor.darkGray.cgColor
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
            return "error time"
        }
    }
    func setColorByTypeOfClass(type: String) -> UIColor {
        switch type.uppercased() {
        case "ЛК":
            return Colors.secondTheme.skyBlue
        case "ПР":
            return Colors.defaultTheme.red
        case "ЛАБ":
            return Colors.defaultTheme.darkBlue
        default:
            return Colors.secondTheme.black
        }
    }


}
