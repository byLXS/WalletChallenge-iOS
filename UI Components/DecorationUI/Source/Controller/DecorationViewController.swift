import UIKit
import RSThemeKit
import WalletPresentationData

public class DecorationViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: ThemeTableView!
  
    var model: [[ThemeType]] = [[.system], [.light, .dark]]
   
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.choiceTheme
        setupTableView()
    }
    
    public init() {
        super.init(nibName: "DecorationViewController", bundle: Bundle(for: DecorationViewController.self))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupTableView() {
        self.tableView.register(SwitchCell.nib, forCellReuseIdentifier: SwitchCell.name)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension DecorationViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && ThemeManager.isSystemTheme {
            return 0
        }
        return model[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ThemeTableCell()
        cell.addThemeObserver()
        let type = model[indexPath.section][indexPath.row]
        
        if type.identifier() == ThemeManager.currentTheme.identifier {
            cell.accessoryType = .checkmark
            if !ThemeManager.isSystemTheme, ThemeManager.currentTheme.identifier == "system" {
                 ThemeManager.isSystemTheme = true
                 tableView.reloadData()
            }
        }
        
        switch type {
        case .system:
            guard let switchCell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return cell }
            switchCell.addTarget()
            switchCell.switchView.isOn = ThemeManager.isSystemTheme
            switchCell.delegate = self
            switchCell.titleLabel.text = Strings.system
            return switchCell
        case .light:
            cell.textLabel?.text = Strings.light
        case .dark:
            cell.textLabel?.text = Strings.dark
        default:
            break
        }
        
        return cell
    }
}

extension DecorationViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = model[indexPath.section][indexPath.row]
        switch type {
        case .system:
            break
        default:
            ThemeManager.setTheme(type: type)
            
        }
        tableView.reloadData()
    }
    
}

extension DecorationViewController: SwitchDelegate {
    func changedValue(isOn: Bool) {
        ThemeManager.isSystemTheme = isOn
        tableView.reloadData()
    }
}
