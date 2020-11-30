import UIKit
import RSThemeKit
import CommonUI
import WalletPresentationData

public class FoldersViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: ThemeTableView!
    
    var interactor: FoldersInteractorProtocol?
    var router: FoldersRouter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.cardFolders
        setupTableView()
        setupNavigationBar()
    }
    
    public init() {
        super.init(nibName: "FoldersViewController", bundle: Bundle(for: FoldersViewController.self))
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

    @objc func addFolder() {
        let title = Strings.createNewFolder
        let message = Strings.enterFolderName
        Alerts.showTextFieldAlert(self, textFieldText: "", title: title, message: message, okButtonTitle: Strings.create, cancelButtonTitle: Strings.cancel) { [weak self] (value) in
            self?.interactor?.addFolder(name: value)
            guard let interactor = self?.interactor else { return }
            let count = interactor.numberOfItemsInSection(section: 0)
            let row = (count - 1) <= 0 ? 0 : count - 1
            self?.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            self?.setupNavigationBar()
        }
    }
    
    @objc func editItems() {
        self.tableView.isEditing = !(self.tableView.isEditing == true)
        self.navigationItem.rightBarButtonItem?.title = (self.tableView.isEditing == true) ? Strings.done : Strings.edit
    }

}
