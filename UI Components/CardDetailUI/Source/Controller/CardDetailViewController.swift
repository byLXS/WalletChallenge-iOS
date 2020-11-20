import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

public class CardDetailViewController: ThemeViewController {
    
    var tableView = ThemeTableView()
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var cancelButton: UIButton!

    var interactor: CardDetailInteractorProtocol?
    let cardDetailHeaderView = CardDetailHeaderView.loadFromNib()

    public override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = interactor?.getNameCard()
        cancelButton.setImage(getImage(named: "cancel_circle_image", anyClass: CardLargeCollectionViewCell.self), for: .normal)
        setupTableView()
        setupStackView()
        cardDetailHeaderView.addThemeObserver()
    }
    
    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        self.view.backgroundColor = theme.tableViewColor
        self.tableView.backgroundColor = theme.tableViewColor
    }
    
    public init() {
        super.init(nibName: "CardDetailViewController", bundle: Bundle(for: CardDetailViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTableView() {
        cardDetailHeaderView.collectionView.dataSource = self
        cardDetailHeaderView.collectionView.delegate = self
        let y = cancelButton.frame.origin.y + 30 + 18
        tableView.frame = CGRect(x: 0, y: cancelButton.frame.origin.y + 30 + 18, width: UIScreen.main.bounds.width, height: self.view.frame.height - y)
        self.view.addSubview(tableView)
        tableView.setNeedsLayout()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BarcodeTableViewCell.nib, forCellReuseIdentifier: BarcodeTableViewCell.name)
        tableView.register(CardDetailTextTableViewCell.nib, forCellReuseIdentifier: CardDetailTextTableViewCell.name)
    }
    
    
    func setupStackView() {
        self.cardDetailHeaderView.stackView.removeAllArrangedSubviews()
        guard let values = interactor?.getCardSideTypes() else { return }
        for value in values {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 7.5).isActive = true
            view.widthAnchor.constraint(equalToConstant: 7.5).isActive = true
            let isSelected = value == interactor?.selectedCardSideType
            let currentTheme = ThemeManager.currentTheme
            view.backgroundColor = isSelected ? currentTheme.textColor : currentTheme.stackViewDisabled
            view.layer.cornerRadius = 4
            view.clipsToBounds = true
            self.cardDetailHeaderView.stackView.addArrangedSubview(view)
        }
    }
    
    @IBAction func skipScreen() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension CardDetailViewController: CardPresentedProtocol {
    public var finalRect: CGRect {
        return CGRect(x: CardLayout.x, y: tableView.frame.origin.y, width: CardLayout.width, height: CardLayout.height)
    }
}


extension CardDetailViewController: CardProtocol {
    public func getCardView() -> CardView? {
        return cardDetailHeaderView.cardView
    }
}
