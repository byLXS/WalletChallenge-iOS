import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

public class FolderItemViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: ThemeTableView!
    
    var interactor: FolderItemInteractorProtocol?
    var router: FolderItemRouter?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = interactor?.getFolder().name ?? ""
        setupTableView()
        setupNavigationBar()
    }
    
    public init() {
        super.init(nibName: "FolderItemViewController", bundle: Bundle(for: FolderItemViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        tableView.backgroundColor = theme.tableViewColor
        view.backgroundColor = theme.tableViewColor
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func setupNavigationBar() {
        let state = !((interactor?.numberOfItemsInSection(section: 0) ?? 0) <= 0)
        self.navigationItem.rightBarButtonItem = state ? UIBarButtonItem(title: Strings.edit, style: .plain, target: self, action: #selector(editItems)) : nil
    }
    
    @objc func editItems() {
        self.tableView.isEditing = !(self.tableView.isEditing == true)
        self.navigationItem.rightBarButtonItem?.title = (self.tableView.isEditing == true) ? Strings.done : Strings.edit
    }
    
    @objc func addCard() {
        router?.presentCardList()
    }
}
