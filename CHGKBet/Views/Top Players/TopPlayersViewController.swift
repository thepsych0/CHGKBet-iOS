import UIKit

class TopPlayersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var presenter = TopPlayersPresenter(topPlayersViewController: self)
    var players: [PlayerInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()

        presenter.requestPlayers()
    }
}

extension TopPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier
        ) as? BasicCell else { return UITableViewCell() }
        cell.configure(model: players[indexPath.row], indexPath: indexPath)
        return cell
    }
}

private let cellIdentifier = "BasicCell"
