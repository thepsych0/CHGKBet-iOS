import UIKit
import Moya

class TournamentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var presenter = LinePresenter(tournamentsViewController: self)
    var tournaments: [Tournament] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.tableFooterView = UIView()
        presenter.requestTournaments()
    }
}

extension TournamentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TournamentCell
            else { return UITableViewCell() }
        cell.tournament = tournaments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.goToGames(tournament: tournaments[indexPath.row])
    }
}

private let cellIdentifier = "TournamentCell"
