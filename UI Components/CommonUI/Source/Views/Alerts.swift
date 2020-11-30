import Foundation
import UIKit
import RSThemeKit
import WalletPresentationData

public class AlertCustomButton {
    let title: String
    let action: () -> ()
    
    init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }
}

public enum AlertActionType {
    case cancel
    case custom(button: AlertCustomButton)
    
    var title: String {
        switch self {
        case .cancel:
            return Strings.cancel
        case .custom(let button):
            return button.title
        }
    }
}

public class Alerts {
    
    static private weak var actionToEnable : UIAlertAction?
    
    
    public static func showInfoAlert(_ controller: UIViewController, preferredStyle: UIAlertController.Style = .actionSheet, title: String? = nil, message: String? = nil, buttonTitle: String) {
        let alertController = ThemeAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    public static func showTextFieldAlert(_ controller: UIViewController, textFieldText: String? = nil, title: String? = nil, message: String? = nil, okButtonTitle: String, cancelButtonTitle: String? = nil, completion: @escaping (String) -> Void) {
        let alertController = ThemeAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = textFieldText
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        if cancelButtonTitle != nil {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { [weak alertController] (_) in
            guard let textField = alertController?.textFields?.first, let text = textField.text  else { return }
            completion(text)
        })
        
        
        alertController.addAction(okAction)
        
        self.actionToEnable = okAction
        okAction.isEnabled = false
        
        controller.present(alertController, animated: true, completion: nil)
    }
    
    public static func showActionAlert(_ controller: UIViewController, title: String? = nil, message: String? = nil, style: UIAlertController.Style, actionAlert: [AlertActionType], completion: @escaping (AlertActionType) -> Void) {
        
        let alertController = ThemeAlertController(title: title, message: message, preferredStyle: style)
        
        var actions: [UIAlertAction] = []
        for action in actionAlert {
            
            switch action {
            case .cancel:
                let alertAction = UIAlertAction(title: action.title, style: .cancel, handler: nil)
                actions.append(alertAction)
            case .custom(let button):
                let alertAction = UIAlertAction(title: action.title, style: .default) { (alertAction) in
                    button.action()
                    completion(action)
                }
                actions.append(alertAction)
            }
        }
        
        for action in actions {
            alertController.addAction(action)
        }
        
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @objc static private func textChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.actionToEnable?.isEnabled = text.count >= 3
    }
}
