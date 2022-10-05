//
//  PresentationAnimatedTransitioning.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 04.10.2022.
//

import UIKit

class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("🖥 animateTransition(using transitionContext in PresentationAnimatedTransitioning")
//        transitionMode == .present ? presentTransition(using: transitionContext) : dismissTransition(using: transitionContext)
        presentTransition(using: transitionContext)
    }
}
// На время, пока не работает, сделал глобальную переменную, чтобы проверить работоспособность анимирования
var globalCell = UICollectionViewCell() // Delete // Delete // Delete // Delete // Delete // Delete // Delete // Delete // Delete // Delete

extension AnimatedTransitioning {

    func presentTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /*
         Ниже написал, как по идее должно работать, но виснет на касте fromViewController т.к. приходит TabBar
         */
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? NewsElementVC,
            let fromViewController = transitionContext.viewController(forKey: .from) as? NewsViewController,
            let fromView = fromViewController.view as? NewsView,
            let newsCell = fromView.selectedCell,
            let newsCellView = newsCell.contentView as? NewsContentView
        else {
            return
        }

        let newsElementTopPicture = toViewController.topPicture
        let cellImage = newsCellView.picture
        
            // Container view
        let container = transitionContext.containerView

            // Entire cell
        let cellView = UIView()
        cellView.frame = container.convert(newsCellView.frame, from: newsCell)
        cellView.layer.cornerRadius = newsCellView.layer.cornerRadius
        cellView.contentMode = newsCellView.contentMode
        cellView.backgroundColor = newsCellView.backgroundColor

            // Cell image
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.frame = container.convert(cellImage.frame, from: newsCell)
        imageView.layer.cornerRadius = cellImage.layer.cornerRadius
        imageView.contentMode = cellImage.contentMode
        imageView.image = cellImage.image

            // Subviews
        container.addSubview(toViewController.view)
        container.addSubview(cellView)
        container.addSubview(imageView)
        toViewController.view.isHidden = true

            // Animating
        let animator = UIViewPropertyAnimator(duration: 2.0, dampingRatio: 0.75) {
            // Cell
            cellView.frame = container.convert(toViewController.view.frame, from: toViewController.view)
            cellView.backgroundColor = toViewController.view.backgroundColor
            // Image
            imageView.contentMode = newsElementTopPicture.contentMode
            imageView.frame = CGRect(x: 0, y: 0, width: 390, height: 390)
            imageView.layer.cornerRadius = 0
            // Hide tabBar
            toViewController.tabBarController?.tabBar.frame.origin.y = toViewController.view.frame.size.height
        }

            // Completion code
        animator.addCompletion { position in
            toViewController.view.isHidden = false
            cellView.removeFromSuperview()
            imageView.removeFromSuperview()
            transitionContext.completeTransition(position == .end)
        }

            // Start
        animator.startAnimation()
    }
}
