import UIKit

class EventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: LinePresenter?
    var events: [Event] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        tableView.tableFooterView = UIView()
        
        presenter?.requestEvents()
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? EventOptionCell
            else { return UITableViewCell() }
        let eventOption = events[indexPath.section].options[indexPath.row]
        cell.model = EventOptionCellModel(eventOption: eventOption, isAvailable: events[indexPath.section].isAvailable)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard events[indexPath.section].isAvailable else { return }
        presenter?.goToBetting(bet: Bet(event: events[indexPath.section], selectedOptionIndex: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = events[section].title
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray

        headerView.addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15)
            ]
        )

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

private let cellIdentifier = "EventOptionCell"
