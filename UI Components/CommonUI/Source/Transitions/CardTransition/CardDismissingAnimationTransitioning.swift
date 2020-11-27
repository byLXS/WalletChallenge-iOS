import Foundation
import UIKit

class CardDismissingAnimationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var finalRect: CGRect
    var cardView: CardView
    
    init(finalRect: CGRect, cardView: CardView) {
        self.finalRect = finalRect
        self.cardView = cardView
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromController = transitionContext.viewController(forKey: .from), let fromControllerCardView = (fromController as? CardProtocol)?.getCardView() else { return }

        self.cardView.isHidden = true
        let containerView = transitionContext.containerView
        let startRect = (fromController as? CardPresentedProtocol)?.finalRect ?? CGRect.zero
        let toController = transitionContext.viewController(forKey: .to)
        let snapshotView = toController?.view.snapshotView(afterScreenUpdates: true)
        
        fromControllerCardView.isHidden = true

        fromController.view.alpha = 1
        
        containerView.addSubview(snapshotView!)
        snapshotView?.frame = containerView.frame
        snapshotView?.alpha = 0
        
        let copyCardView = CardView.getCardCopy(cardView: cardView)
        copyCardView.frame = startRect
        containerView.addSubview(copyCardView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            copyCardView.frame = self.finalRect
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            fromController.view.alpha = 0
        }, completion: { _ in
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(UINotificationFeedbackGenerator.FeedbackType.success)
        })
        UIView.animate(withDuration: 0.6, delay: 0.6, animations: {
            snapshotView?.alpha = 1
        }, completion: { finished in
            self.cardView.isHidden = false
            snapshotView?.removeFromSuperview()
            transitionContext.completeTransition(finished)
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
}
