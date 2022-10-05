//
//  TransitioningDelegate.swift
//  MIREA Application
//
//  Created by Кирилл Пигалкин on 04.10.2022.
//

import UIKit

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        print("🖥 presentationController(present) in TransitioningDelegate")
        printVC(forPresented: presented, presenting: presenting, source: source)// delete// delete// delete// delete// delete// delete
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("🖥 animationController in TransitioningDelegate")
        printVC(forPresented: presented, presenting: presenting, source: source)// delete// delete// delete// delete// delete// delete
        return AnimatedTransitioning()
    }
}

// delete // delete // delete // delete // delete // delete // delete // delete // delete // delete // delete // delete // delete
extension TransitioningDelegate {
    func printVC(forPresented presented: UIViewController,
                 presenting: UIViewController?,
                 source: UIViewController) {
        print("presented: \(presented)")
        print("presenting: \(presenting)")
        print("source: \(source)")
    }
}
