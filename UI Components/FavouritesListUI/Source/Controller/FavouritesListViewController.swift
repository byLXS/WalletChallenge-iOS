import UIKit
import WalletPresentationData
import CommonUI
import RSThemeKit

public class FavouritesListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: ThemeCollectionView!
    
    var interactor: FavouritesListInteractorProtocol?
    var router: FavouritesListRouter?

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.favourites
        setupCollectionView()
    }
    
    public init() {
        super.init(nibName: "FavouritesListViewController", bundle: Bundle(for: FavouritesListViewController.self))
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
