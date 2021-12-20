//
//  AnimationController.swift
//  Bottle Rocket
//
//  Created by Teodora Mratinkovic on 11/24/21.
//

import UIKit

class Animation: NSObject {
    
    private let animationType: AnimationType
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    init(animationType: AnimationType) {
        self.animationType = animationType
    }
}

extension Animation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toViewController.view)
            presentAnimation(with: transitionContext, viewToAnimate: toViewController.view)
        case .dismiss:
            transitionContext.containerView.addSubview(fromViewController.view)
            dismissAnimation(with: transitionContext, viewToAnimate: fromViewController.view)
        }
    }
    
    func presentAnimation(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        let duration = transitionDuration(using: transitionContext)
        viewToAnimate.clipsToBounds = true
        viewToAnimate.transform = CGAffineTransform(translationX: viewToAnimate.bounds.width - 10, y: -viewToAnimate.bounds.height + 10)
        UIView.animate(withDuration: duration) {
            viewToAnimate.transform = .identity
            transitionContext.completeTransition(true)
        }
    }
    
    func dismissAnimation(with transictionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        let duration = transitionDuration(using: transictionContext)
        UIView.animate(withDuration: duration, animations: {
            viewToAnimate.transform = CGAffineTransform(translationX: -viewToAnimate.bounds.width, y: -viewToAnimate.bounds.height)
        }) { _ in
            transictionContext.completeTransition(true)
        }
    }
}
