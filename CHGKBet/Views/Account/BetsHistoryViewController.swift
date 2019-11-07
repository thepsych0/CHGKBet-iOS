import UIKit

class BetsHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: AccountPresenter?
    var bets: [BetHistory] = [] {
        didSet {
            guard isBeingPresented else { return }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
    }
}

extension BetsHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier
            ) as? BetHistoryCell else { return UITableViewCell() }
        cell.bet = bets[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

private let cellIdentifier = "BetHistoryCell"
