import UIKit

class FAQQuestionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: FAQPresenter?
    var faqSection: FAQ.Section? {
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

extension FAQQuestionsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return faqSection?.questions.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FAQAnswerCell else {
            return UITableViewCell()
        }
        cell.answer = faqSection?.questions[indexPath.section].answer
        return cell
    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let cell = tableView.cellForRow(at: indexPath) as? FAQAnswerCell else { return 0 }
//        return cell.height
//    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)

        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = faqSection?.questions[section].question
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray

        headerView.addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
                label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 15)
            ]
        )

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

private let cellIdentifier = "FAQAnswerCell"
