import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

protocol CardListViewDelegate: class {
    func folderItemsChanged()
}

public class CardListViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: ThemeTableView!
    @IBOutlet weak var applyButton: SuperEllipseButton!
    
    var interactor: CardListInteractorProtocol?
    
    var delegate: CardListViewDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupApplyButton()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.cancel, style: .done, target: self, action: #selector(dismissController))
    }
    
    public init() {
        super.init(nibName: "CardListViewController", bundle: Bundle(for: CardListViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.bottom = 80
        tableView.showsVerticalScrollIndicator = false
    }
    
    func setupApplyButton() {
        applyButton.setTitle(Strings.apply, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
    }
    
    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        view.backgroundColor = theme.backgroundColor
        tableView.backgroundColor = theme.backgroundColor
        applyButton.backgroundColor = theme.tintColor
        applyButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func apply() {
        guard let interactor = interactor else { return }
        interactor.apply()
        delegate?.folderItemsChanged()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}

extension CardListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.numberOfItemsInSection(section: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardItemTableViewCell()
        cell.addThemeObserver()
        if let item = interactor?.getItem(indexPath: indexPath) {
            cell.imageView?.image = nil
            cell.textLabel?.text = item.card.issuer.name
            cell.accessoryType = item.isSelected ? .checkmark : .none
            interactor?.loadImage(indexPath: indexPath, completion: { (image) in
                cell.imageView?.image = image
                let itemSize = CGSize.init(width: 120, height: 80)
                UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
                let imageRect = CGRect.init(origin: CGPoint.zero, size: itemSize)
                cell.imageView?.image!.draw(in: imageRect)
                cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
                UIGraphicsEndImageContext();
                cell.layoutSubviews()
            })
        }
        return cell
    }
    
    
}
extension CardListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        interactor?.setItemSelected(indexPath: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

class CardItemTableViewCell: ThemeTableCell {
    
    override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        backgroundColor = theme.backgroundColor
    }
}
