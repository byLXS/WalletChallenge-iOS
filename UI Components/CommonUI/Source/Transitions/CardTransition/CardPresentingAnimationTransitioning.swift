import Foundation
import UIKit

class CardPresentingAnimationTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let startRect: CGRect
    let cardView: CardView
    
    init(startRect: CGRect, cardView: CardView) {
        self.startRect = startRect
        self.cardView = cardView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let finalFrameForPresentedView = transitionContext.finalFrame(for: toController)
        let finalRect = (toController as? CardPresentedProtocol)?.finalRect ?? CGRect.zero
        
        let backView = UIView()
        backView.frame = finalFrameForPresentedView
        backView.backgroundColor = toController.view.backgroundColor
        backView.alpha = 0
        containerView.addSubview(backView)
        
        cardView.isHidden = true
        
        let cardViewCopy = CardView.getCardCopy(cardView: cardView)
        
        let presentedCardView = (toController as? CardProtocol)?.getCardView()
        presentedCardView?.isHidden = true
        
        cardViewCopy.frame = self.startRect
        containerView.addSubview(cardViewCopy)
        
        containerView.addSubview(toController.view)
        
        toController.view.alpha = 0
        toController.view.frame = finalFrameForPresentedView
        
        UIScreen.main.setBrightness(to: 10, duration: 0.6, ticksPerSecond: 120)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            cardViewCopy.frame = finalRect
        }, completion: { finished in
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.0, animations: {
            backView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.6, animations: {
            toController.view.alpha = 1
            presentedCardView?.isHidden = false
        }, completion: { finished in
            presentedCardView?.isHidden = false
            self.cardView.isHidden = false
            cardViewCopy.removeFromSuperview()
            transitionContext.completeTransition(finished)
        })
    }
    
    
}
