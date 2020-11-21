import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

protocol CardFilterDisplayLogic {
    func scrollToItem(indexPath: IndexPath)
}

open class CardFilterViewController: ThemeViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var collectionView: ThemeCollectionView!
    @IBOutlet weak var categoryCollectionView: ThemeCollectionView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var cardTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var applyButton: SuperEllipseButton!

    var interactor: CardFilterInteractorProtocol?
    var router: CardFilterRouter?
    
    weak var delegate: CardFilterDelegate?
    
    var onceOnly = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupApplyButton()
        setupStackView()
        setupCollectionView()
        setupCategoryCollectionView()
        setupCardTypeSegmentedControl()
        cancelButton.setImage(getImage(named: "cancel_circle_image", anyClass: CardLargeCollectionViewCell.self), for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        clearButton.setTitle(Strings.clear, for: .normal)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
            collectionView.overrideUserInterfaceStyle = .dark
        }
    }


    public init() {
        super.init(nibName: "CardFilterViewController", bundle: Bundle(for: CardFilterViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !onceOnly {
            interactor?.scrollToSelectedStyleItem()
            onceOnly = true
        }
    }

    open override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        clearButton.setTitleColor(theme.tintColor, for: .normal)
        applyButton.backgroundColor = theme.tintColor
        applyButton.setTitleColor(.white, for: .normal)
        collectionView.backgroundColor = theme.backgroundColor
        categoryCollectionView.backgroundColor = theme.backgroundColor
        setupStackView()
    }
    
    func setupStackView() {
        self.stackView.removeAllArrangedSubviews()
        guard let values = interactor?.cardPresentationStyleItems else { return }
        for value in values {
            let view = UIView()
            view.heightAnchor.constraint(equalToConstant: 7.5).isActive = true
            view.widthAnchor.constraint(equalToConstant: 7.5).isActive = true
            let isSelected = value == interactor?.cardFilter.cardPresentationStyle
            let currentTheme = ThemeManager.currentTheme
            view.backgroundColor = isSelected ? currentTheme.textColor : currentTheme.stackViewDisabled
            view.layer.cornerRadius = 4
            view.clipsToBounds = true
            self.stackView.addArrangedSubview(view)
        }
    }
    
    func setupApplyButton() {
        applyButton.setTitle(Strings.apply, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
    }
    
    func setupCollectionView() {
        categoryCollectionView.tag = CardFilterCollectionType.style.rawValue
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardPresentationStyleCollectionViewCell.nib, forCellWithReuseIdentifier: CardPresentationStyleCollectionViewCell.name)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.isPagingEnabled = true
    }
    
    func setupCategoryCollectionView() {
        categoryCollectionView.tag = CardFilterCollectionType.category.rawValue
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.name)
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    func setupCardTypeSegmentedControl() {
        cardTypeSegmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
        cardTypeSegmentedControl.removeAllSegments()
        var selectedIndex = 0
        let values: [CardFilterType] = [.all, .loyalty, .certificate]
        for (index, value) in values.enumerated() {
            if interactor?.cardFilter.cardType ?? .all == value {
                selectedIndex = index
            }
            cardTypeSegmentedControl.insertSegment(withTitle: value.title, at: index, animated: false)
        }
        
        cardTypeSegmentedControl.selectedSegmentIndex = selectedIndex
    }
    
    @objc func clearFilter() {
        guard let interactor = interactor else { return }
        self.interactor?.clearFilter()
        self.delegate?.apply(filter: interactor.cardFilter)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func apply() {
        guard let interactor = interactor else { return }
        self.interactor?.cardFilter.isSelected = true
        self.delegate?.apply(filter: interactor.cardFilter)
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func segmentedValueChanged() {
        let index = cardTypeSegmentedControl.selectedSegmentIndex
        interactor?.cardFilter.cardType = CardFilterType(rawValue: index) ?? .all
    }
    
}

extension CardFilterViewController: CardFilterDisplayLogic {
    func scrollToItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
