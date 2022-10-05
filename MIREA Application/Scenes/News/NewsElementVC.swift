//
//  SpecificNewsVC.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 12.08.2022.
//

import UIKit

final class NewsElementVC: UIViewController {
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = Color.defaultDark.lightText
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
        textView.linkTextAttributes = [.foregroundColor : Color.defaultDark.red.withAlphaComponent(0.7)]
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Color.defaultDark.lightText
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
    
    let topPicture: UIImageView = {
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
    }
    
    func configure(data: NewsModels.NewsElement.ViewModel) {
        print("⭕️ configure in NewsElementVC()")
        view.backgroundColor = Color.defaultDark.lightBlue
        imageZoomScrollView.delegate = self
        setupImage(id: data.id, url: data.imageURL)
        textView.attributedText = makeLinks(in: data.text)
        textView.font = .systemFont(ofSize: 16, weight: .medium)
        textView.textColor = Color.defaultDark.lightText
        titleLabel.text = data.title
        dateLabel.text = data.date
    }
    
    private func setNavigationBar() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topPicture.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topPicture.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            topPicture.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            topPicture.heightAnchor.constraint(equalTo: scrollView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: topPicture.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            textView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(lessThanOrEqualTo: textView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -10),
            
            imageZoomScrollView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
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
}

    // MARK: UIScrollViewDelegate for image zooming

extension NewsElementVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomPicture
    }
}

    // MARK: Detect links & setup images

private extension NewsElementVC {
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
//        navigationController?.popViewController(animated: false)
        dismiss(animated: false)
    }
    
    func makeLinks(in textFromServer: String) -> NSMutableAttributedString {
        let words = splitIntoWords(in: textFromServer)
        let text = NSMutableAttributedString(string: "")
       
        words.forEach { word in
            let shouldSelect = word.hasPrefix("@") || word.hasPrefix("#") || word.hasPrefix("http")
            if shouldSelect {
                let link = NSMutableAttributedString(string: word)
                link.addAttribute(.link,
                                  value: "https://www.apple.com",
                                  range: NSRange(location: 0, length: word.count))
                text.append(link)
            } else {
                text.append(NSAttributedString(string: word))
            }
            guard let wordIndex = words.firstIndex(of: word) else { return }
            if (word != words.last) && (words[wordIndex + 1] != ".") { /// Don't append space before "."
                text.append(NSAttributedString(string: " "))
            }
        }
        return text
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
    
    func setupImage(id: Int, url: URL?) {
        guard let url = url else {
            return
        }
        topPicture.sd_setImage(with: url)
        zoomPicture.sd_setImage(with: url)
    }
    
}
