//
//  SpecificNewsVC.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 12.08.2022.
//

import UIKit

final class SpecificNewsVC: UIViewController, UIScrollViewDelegate {
    
    var data: NewsModels.SpecificNews.ViewModel
    
    init(data: NewsModels.SpecificNews.ViewModel){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .black.withAlphaComponent(0.7)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label.withAlphaComponent(0.8)
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
        setGradientBackground()
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
        textLabel.text = formatingText(text: data.text)
        titleLabel.text = data.title
        
        print("⭕️ configure in SpecificNews()")
        setupImage(picture)
        // calculate aspect ratio and set default image
        if picture.image == nil {
            picture.image = UIImage(named: "rtu-mirea-image")
        }
        aspectRatio = picture.image!.size.width / picture.image!.size.height

        
        var date = data.date
        if date != "empty" {date.removeLast(19)}
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
        let id = data.id
        
        let imageExists = NewsContentView.imageDictionary[id] != nil
        if imageExists {
            picture.image = NewsContentView.imageDictionary[id]
        }
        else {
            let defaultImage = UIImage(named: "rtu-mirea-image")
            DispatchQueue.global().async {
                do {
                    if let url = URL(string: self.data.url) {
                        let data = try Data(contentsOf: url)
                        let img = UIImage(data: data)
                        picture.image = img ?? defaultImage!
                        NewsContentView.imageDictionary[id] = picture.image
                    }
                }
                catch {
                    print("Error: Specific image with id \(self.data.id) isn't setted")
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
        let space = "    "

        let _ = text.components(separatedBy: "⠀").map({
            finalText += $0 + "\n\n" + space
        })
        
        return space + finalText
    }
    
    func setGradientBackground() {
        let colorTop = Colors.defaultTheme.sand.cgColor
        let colorBottom = Colors.defaultTheme.darkBlue.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.3, 1.3]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
    
