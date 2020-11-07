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
        self.view.backgroundColor = theme.tableViewColor
        visualEffectView.effect = theme.blurEffect
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
    }
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardLargeCollectionViewCell.self, forCellWithReuseIdentifier: CardLargeCollectionViewCell.identifier)
    }

}

extension MainViewController: MainDisplayLogic {
    func reloadList() {
        collectionView.reloadData()
    }
    
    
}
