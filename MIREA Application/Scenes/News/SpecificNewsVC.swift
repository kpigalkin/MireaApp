//
//  SpecificNewsVC.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 12.08.2022.
//

import UIKit

final class SpecificNewsVC: UIViewController, UIScrollViewDelegate {
    
    var data: NewsModels.SpecificNews.ViewModel?
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .darkText
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    private let picture: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var aspectRatio: CGFloat?
    
    override func viewDidLoad() {
        print("⭕️ viewDidLoad in SpecificNewsVC")
        super.viewDidLoad()
        setupNavigationController()
        configure()
        addSubviews()
        makeConstraints()
        setupZoom()
    }

    override func viewWillAppear(_ animated: Bool) {
        configure()
    }

    private func makeConstraints() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        picture.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            picture.topAnchor.constraint(equalTo: scrollView.topAnchor),
            picture.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            picture.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            picture.heightAnchor.constraint(equalTo: picture.widthAnchor, multiplier: 1/aspectRatio!),
            
            titleLabel.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: Constants.heightPadding),
            titleLabel.widthAnchor.constraint(equalTo: picture.widthAnchor, constant: -15),
            titleLabel.centerXAnchor.constraint(equalTo: picture.centerXAnchor),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.heightPadding),
            textLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -25),
            textLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.heightPadding),
            dateLabel.leadingAnchor.constraint(lessThanOrEqualTo: textLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: -Constants.padding),
            dateLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)
        ])
    }
    
    private func configure() {
        view.backgroundColor = .white
        textLabel.text = formatingText(text: data?.text)
        titleLabel.text = data?.title
        
        print("⭕️ configure in SpecificNews()")
        setupImage(picture)
        // calculate aspect ratio and set default image
        if picture.image == nil {
            picture.image = UIImage(named: "rtu-mirea-image")
        }
        aspectRatio = picture.image!.size.width / picture.image!.size.height

        
        var date = data?.date
        if date != "empty" {date?.removeLast(19)}
        dateLabel.text = date
    }
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(picture)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(textLabel)
        scrollView.addSubview(dateLabel)
    }
    func setupNavigationController() {
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
    
    func setupImage(_ picture: UIImageView) {
        // MARK: Checking out already-downloaded images in <imageDictionary>
        let id = data?.id ?? 0
        
        let imageExists = NewsView.imageDictionary[id] != nil
        if imageExists {
            picture.image = NewsView.imageDictionary[id]
        }
        else {
            let defaultImage = UIImage(named: "rtu-mirea-image")
            DispatchQueue.global().async {
                do {
                    if let url = URL(string: self.data?.url ?? "") {
                        let data = try Data(contentsOf: url)
                        let img = UIImage(data: data)
                        picture.image = img ?? defaultImage!
                        NewsView.imageDictionary[id] = picture.image
                    }
                }
                catch {
                    print("Error: Specific image with title \(self.data?.id ?? 0) isn't setted")
                }
            }
        }
    }
    
    func setupZoom() {
//        scrollView.delegate = self
//        scrollView.minimumZoomScale = 0.1
//        scrollView.maximumZoomScale = 4.0
//        scrollView.zoomScale = 1.0
    }
}

extension SpecificNewsVC {
    func formatingText(text: String?) -> String {
        guard let text = text else { return "" }
        var finalText: String = ""

//        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
//        let characterset = CharacterSet(charactersIn: <#T##Range<Unicode.Scalar>#>)
//
//
//        if text.rangeOfCharacter(from: characterset.inverted) != nil {
//            print("string contains special characters")
//
//        }
        let _ = text.components(separatedBy: "⠀").map({
            finalText += $0 + "\n\n"
        })
//        print(finalText)
        
        return finalText
    }
}
    
