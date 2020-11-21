import UIKit
import CommonUI
import WalletPresentationData
import RSThemeKit

protocol MainDisplayLogic {
    func reloadList()
}

public class MainViewController: ThemeViewController {
    
    @IBOutlet weak var collectionView: ThemeCollectionView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var interactor: MainInteractorProtocol?
    var router: MainRouter?
    
    public init() {
        super.init(nibName: "MainViewController", bundle: Bundle(for: MainViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.main
        setupNavigationBar()
        setupCollectionView()
        interactor?.fetchCardList()
        // Do any additional setup after loading the view.
    }
    
    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        self.collectionView.backgroundColor = theme.backgroundColor
        self.view.backgroundColor = theme.backgroundColor
        visualEffectView.effect = theme.blurEffect
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        
        let button = AddButton()
        button.setup()
        button.setTitle(Strings.add, for: .normal)
        button.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 28)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
        
        let userImage = getImage(named: "user_image", anyClass: type(of: self))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: userImage, style: .done, target: self, action: #selector(openSettings))
    }
    
    func setupCollectionView() {
        collectionView.contentInset.bottom = 30
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardLargeCollectionViewCell.self, forCellWithReuseIdentifier: CardLargeCollectionViewCell.identifier)
        collectionView.register(MainCollectionReusableView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainCollectionReusableView.name)
    }

    @objc func addCard() {
        print(1)
    }
    
    @objc func openSettings() {
        print(2)
    }
    
    @objc func showFilterScreen() {
        self.router?.presentFilterScreen()
    }
}

extension MainViewController: MainDisplayLogic {
    func reloadList() {
        collectionView.reloadData()
    }
    
    
}
extension MainViewController: CardFilterDelegate {
    public func apply(filter: CardFilter) {
        self.interactor?.cardFilter = filter
        self.interactor?.reloadItems()
        self.collectionView.reloadData()
    }
}
