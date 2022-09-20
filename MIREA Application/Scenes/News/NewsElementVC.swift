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
        return scrollView
    }()
    
    private let imageZoomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let textLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = .label.withAlphaComponent(0.88)
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.dataDetectorTypes = .link
        textView.linkTextAttributes = [.foregroundColor : Colors.defaultTheme.red.withAlphaComponent(0.7)]
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .darkText
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    private var aspectRatio: CGFloat = 0.75 // Default 16:10 0.625
    private let picture: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.contentScaleFactor = 10
        return view
    }()
    
    override func viewDidLoad() {
        print("⭕️ viewDidLoad in NewsElementVC")
        super.viewDidLoad()
        view.backgroundColor = Colors.defaultTheme.lightBlue
        addSubviews()
        makeConstraints()
        configure()
    }
    
    private func configure() {
        print("⭕️ configure in NewsElementVC()")
        imageZoomScrollView.delegate = self
        setupImage()
        textLabel.attributedText = makeLinks(in: data.text)
        textLabel.font = .systemFont(ofSize: 16, weight: .medium)
        textLabel.textColor = .black
        titleLabel.text = data.title
    }

    private func makeConstraints() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        picture.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        imageZoomScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.heightSpace),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            imageZoomScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageZoomScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageZoomScrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageZoomScrollView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: aspectRatio),
            
            picture.centerXAnchor.constraint(equalTo: imageZoomScrollView.centerXAnchor),
            picture.centerYAnchor.constraint(equalTo: imageZoomScrollView.centerYAnchor),
            picture.widthAnchor.constraint(equalTo: imageZoomScrollView.widthAnchor),
            picture.heightAnchor.constraint(equalTo: imageZoomScrollView.heightAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageZoomScrollView.bottomAnchor, constant: Constants.heightSpace),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Constants.heightSpace * 2),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.heightSpace),
            textLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            textLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.heightSpace),
            dateLabel.leadingAnchor.constraint(lessThanOrEqualTo: textLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: -Constants.space),
            dateLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(textLabel)
        scrollView.addSubview(imageZoomScrollView)
        imageZoomScrollView.addSubview(picture)
    }
}

extension NewsElementVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return picture
    }
}

// MARK: Detect links & setup images

private extension NewsElementVC {
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
            picture.image = image
        } else {
            DispatchQueue.global().async {
                do {
                    let defaultImageURL = URL(string: "https://www.mirea.ru/upload/medialibrary/d07/RTS_colour.jpg")!
                    let url = URL(string: self.data.url) ?? defaultImageURL
                    let data = try Data(contentsOf: url)
                    let img = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.picture.image = img
                        NewsContentView.imageDictionary[self.data.id] = self.picture.image
                    }
                }
                catch {
                    print("Error: Image w/id \(self.data.id) not downloaded")
                }
            }
        }
    }
}
