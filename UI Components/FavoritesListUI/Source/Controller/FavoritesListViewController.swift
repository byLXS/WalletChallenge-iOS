import UIKit
import WalletPresentationData
import CommonUI
import RSThemeKit

public class FavoritesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: ThemeCollectionView!
    
    var interactor: FavoritesListInteractorProtocol?
    var router: FavoritesListRouter?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.favourites
        setupCollectionView()
    }
    
    public init() {
        super.init(nibName: "FavoritesListViewController", bundle: Bundle(for: FavoritesListViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardLargeCollectionViewCell.self, forCellWithReuseIdentifier: CardLargeCollectionViewCell.identifier)
    }
}
