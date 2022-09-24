//
//  SpecificNewsVC.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 12.08.2022.
//

import UIKit

final class NewsElementVC: UIViewController {
    var data: NewsModels.NewsElement.ViewModel
   
    init(data: NewsModels.NewsElement.ViewModel){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("NewsElement deinited")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        return scrollView
    }()
    
    private let imageZoomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = Color.defaultTheme.lightText
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.dataDetectorTypes = .link
        textView.linkTextAttributes = [.foregroundColor : Color.defaultTheme.red.withAlphaComponent(0.7)]
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Color.defaultTheme.lightText
        label.textAlignment = .right
        return label
    }()
    
    private let zoomPicture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.contentScaleFactor = 5
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let topPicture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func viewDidLoad() {
        print("⭕️ viewDidLoad in NewsElementVC")
        super.viewDidLoad()
        setNavigationBar()
        addSubviews()
        makeConstraints()
        configure()
    }
    
    private func setNavigationBar() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    private func configure() {
        print("⭕️ configure in NewsElementVC()")
        view.backgroundColor = Color.defaultTheme.lightBlue
        imageZoomScrollView.delegate = self
        setupImage()
        textView.attributedText = makeLinks(in: data.text)
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.textColor = Color.defaultTheme.lightText
        titleLabel.text = data.title
        dateLabel.text = data.date
    }
 
    private func makeConstraints() {
        topPicture.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        zoomPicture.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageZoomScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Const.longSpace),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            topPicture.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topPicture.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            topPicture.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            topPicture.heightAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: topPicture.bottomAnchor, constant: Const.middleSpace),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Const.longSpace),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Const.middleSpace),
            textView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            textView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Const.middleSpace),
            dateLabel.leadingAnchor.constraint(lessThanOrEqualTo: textView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -Const.space),
            
            imageZoomScrollView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Const.middleSpace),
            imageZoomScrollView.widthAnchor.constraint(equalTo: textView.widthAnchor),
            imageZoomScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageZoomScrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.625),
            imageZoomScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            zoomPicture.centerXAnchor.constraint(equalTo: imageZoomScrollView.centerXAnchor),
            zoomPicture.centerYAnchor.constraint(equalTo: imageZoomScrollView.centerYAnchor),
            zoomPicture.widthAnchor.constraint(equalTo: imageZoomScrollView.widthAnchor),
            zoomPicture.heightAnchor.constraint(equalTo: imageZoomScrollView.heightAnchor),
        ])
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(topPicture)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(textView)
        scrollView.addSubview(imageZoomScrollView)
        imageZoomScrollView.addSubview(zoomPicture)
    }
}

extension NewsElementVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomPicture
    }
}

// MARK: Detect links & setup images

private extension NewsElementVC {
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    func makeLinks(in textFromServer: String) -> NSMutableAttributedString {
        let wordsArr = splitIntoWords(in: textFromServer)
        let finalText = NSMutableAttributedString(string: "")
       
        wordsArr.forEach { word in
            let shouldSelect = word.hasPrefix("@") || word.hasPrefix("#") || word.hasPrefix("http")
            if shouldSelect {
                let link = NSMutableAttributedString(string: word)
                link.addAttribute(.link, value: "https://www.apple.com" , range: NSRange(location: 0, length: word.count))
                finalText.append(link)
            } else {
                finalText.append(NSAttributedString(string: word))
            }
            guard let wordIndex = wordsArr.firstIndex(of: word) else { return }
            if word != wordsArr.last && wordsArr[wordIndex + 1] != "." { // Don't append space before "."
                finalText.append(NSAttributedString(string: " "))
            }
        }
        return finalText
    }
    
    func splitIntoWords(in text: String) -> [String] {
        let breakedText = text.components(separatedBy: " ")
        var wordsArr = [String]()
        breakedText.forEach { word in
            if (word.hasPrefix("@") || word.hasPrefix("#")) && word.contains(".") {
                var separatedWord = word.components(separatedBy: ".")
                for index in 0..<separatedWord.count - 1 { // Insert deleted points
                    separatedWord.insert(".", at: index * 2 + 1)
                }
                wordsArr += separatedWord
            } else {
                wordsArr.append(word)
            }
        }
        return wordsArr
    }
    
    func setupImage() {
        /// Checking out already-downloaded images in <imageDictionary>
        if let image = NewsContentView.imageDictionary[data.id] {
            zoomPicture.image = image
            topPicture.image = image
        } else {
            DispatchQueue.global().async {
                do {
                    let defaultImageURL = URL(string: "https://www.mirea.ru/upload/medialibrary/d07/RTS_colour.jpg")!
                    let url = URL(string: self.data.url) ?? defaultImageURL
                    let data = try Data(contentsOf: url)
                    let img = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.zoomPicture.image = img
                        self.topPicture.image = img
                        NewsContentView.imageDictionary[self.data.id] = self.zoomPicture.image
                    }
                }
                catch {
                    print("Error: Image w/id \(self.data.id) not downloaded")
                }
            }
        }
    }
}
