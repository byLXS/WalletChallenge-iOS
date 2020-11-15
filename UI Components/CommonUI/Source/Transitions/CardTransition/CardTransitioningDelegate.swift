import Foundation
import UIKit

extension UIViewController {
    public func presentCard(_ controller: UIViewController, cardView: CardView, complection: (() -> Void)? = nil) {
        let transitionDelegate = CardTransitioningDelegate(cardView: cardView)
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        self.present(controller, animated: true, completion: complection)
    }
}

public final class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var cardView: CardView
    var startRect: CGRect
    
    init(cardView: CardView) {
        self.cardView = cardView
        
        self.startRect = cardView.imageView.convert(cardView.imageView.frame, to: nil)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = CardPresentationController(presentedViewController: presented, presenting: presenting)
        controller.transitioningDelegate = self
        return controller
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentingAnimationTransitioning(startRect: startRect, cardView: cardView)
    }
    
   
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDismissingAnimationTransitioning(finalRect: startRect, cardView: cardView)
    }
    
}

