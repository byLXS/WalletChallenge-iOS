import Foundation
import UIKit
import RSThemeKit

public class NotificationMessage {
    
    public static let shared = NotificationMessage()
    var notificationView: NotificationView?
    var isShowing = false
    
    let keyWindow: UIWindow? = {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? nil
        }

        return UIApplication.shared.delegate?.window ?? nil
    }()
    
    var topSpace: CGFloat {
        if #available(iOS 11.0, *) {
            return keyWindow?.safeAreaInsets.top ?? 0
        }
        return 0
    }
    
    private init() {}
    
    public func present(title: String, message: String) {
        guard !isShowing else { return }
        guard let window = keyWindow else { return }
        self.notificationView = NotificationView(title: title, message: message)
        window.addSubview(notificationView!)
        
        isShowing = true
        playFadeInAnimation(animated: true) { (state) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.playFadeOutAnimation(animated: true) { (_) in
                    self.notificationView?.removeFromSuperview()
                    self.isShowing = false
                }
            }
            
        }
    }
    
    private func playFadeInAnimation(animated: Bool, _ completion: ((Bool) -> Void)?) {
        guard let window = keyWindow, let notificationView = notificationView else { return }
        
        if animated {
            var y: CGFloat
            y = -(notificationView.bounds.height + topSpace + 10)
            
            notificationView.transform = CGAffineTransform(translationX: 0, y: y)

            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                notificationView.transform = .identity
            }, completion: completion)
        } else {
            notificationView.alpha = 0
            
            UIView.animate(withDuration: 0.25, animations: {
                notificationView.alpha = 1
            }, completion: completion)
        }
    }
    
    private func playFadeOutAnimation(animated: Bool, _ completion: ((Bool) -> Void)?) {
        guard let window = keyWindow, let notificationView = notificationView else {
            completion?(false)
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            if animated {
                var y: CGFloat
                y = -(notificationView.bounds.height + self.topSpace + 15)
                
                notificationView.transform = CGAffineTransform(translationX: 0, y: y)
            } else {
                notificationView.alpha = 0
            }
        }, completion: completion)
    }
}

class NotificationView: UIView {
    
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var containerView: UIView!
    
    private var action: (() -> Void)? = nil
    
    let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow } ?? UIWindow()
    
   
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(title: String, message: String) {
        super.init(frame: CGRect.zero)
        
        var topSpace: CGFloat = 0
        if #available(iOS 11.0, *) {
            topSpace = keyWindow.safeAreaInsets.top
        }
        self.frame = CGRect(x: 20, y: topSpace + 15, width: UIScreen.main.bounds.width - 40, height: 72)
        self.setupViews()
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        
        titleLabel.text = title
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        
        messageLabel.text = message
        
        self.containerView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        
        self.containerView.addGestureRecognizer(gestureRecognizer)
        
        addThemeObserver()

    }
    
    func addThemeObserver() {
        ThemeManager.addThemeObserver(self, selector: #selector(changedTheme))
        changedTheme()
    }
    
    @objc func changedTheme() {
        decorator(theme: ThemeManager.currentTheme)
    }
    
    func decorator(theme: ThemeModel) {
        containerView.backgroundColor = theme.cellBackgroundColor
        titleLabel.textColor = theme.textColor
        messageLabel.textColor = theme.textColor
    }

    
    func setupViews() {
        containerView = UIView()
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor(red: 0.169, green: 0.369, blue: 0.318, alpha: 0.15).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 32
        containerView.layer.bounds = bounds
        containerView.layer.position = center
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
    }
    
    @objc private func handleTapAction() {
        action?()
    }
    
}
