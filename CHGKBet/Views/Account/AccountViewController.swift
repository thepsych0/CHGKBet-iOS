import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    lazy var presenter = AccountPresenter(accountViewController: self)

    var name: String? {
        didSet {
            guard isBeingPresented else { return }
            nameLabel.text = name
        }
    }
    var settings: [Setting] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()

        presenter.requestSettings()
    }
}

extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? BasicCell else { return UITableViewCell() }
        cell.configure(model: settings[indexPath.row], indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        settings[indexPath.row].action?()
    }
}

private let cellIdentifier = "BasicCell"
