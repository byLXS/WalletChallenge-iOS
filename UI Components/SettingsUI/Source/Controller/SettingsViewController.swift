import UIKit
import RSThemeKit
import WalletPresentationData

protocol SettingsDisplayLogic {
}

public class SettingsViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: ThemeTableView!
    
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouter?

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.settings
        setupNavigationController()
        setupTableView()
    }
    
    public init() {
        super.init(nibName: "SettingsViewController", bundle: Bundle(for: SettingsViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    public override func decorator(theme: ThemeModel) {
        super.decorator(theme: theme)
        self.view.backgroundColor = theme.tableViewColor
        self.tableView.backgroundColor = theme.tableViewColor
        self.navigationController?.navigationBar.tintColor = theme.tintColor
    }
    
    func setupNavigationController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.done, style: .done, target: self, action: #selector(dismissController))
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileTableViewCell.nib, forCellReuseIdentifier: ProfileTableViewCell.name)
        tableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.name)
    }
    
    func getSettingsImage(presentationType: SettingsPresentationType) -> UIImage? {
        switch presentationType {
        case .profile:
            return getImage(named: "person_circle_image", anyClass: type(of: self))
        case .statistics:
            return getImage(named: "statistics_settings_image", anyClass: type(of: self))
        case .language:
            return getImage(named: "localization_settings_image", anyClass: type(of: self))
        case .decoration:
            return getImage(named: "decoration_settings_image", anyClass: type(of: self))
        case .favourites:
            return getImage(named: "favourites_settings_image", anyClass: type(of: self))
        case .folders:
            return getImage(named: "folders_settings_image", anyClass: type(of: self))
        }
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: SettingsDisplayLogic {
}
