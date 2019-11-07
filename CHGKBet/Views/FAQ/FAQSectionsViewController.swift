import UIKit

class FAQSectionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    lazy var presenter = FAQPresenter(faqSectionsViewController: self)
    var faq: FAQ? {
        didSet {
            guard !isBeingPresented else { return }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        presenter.requestFAQ()
    }
}

extension FAQSectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faq?.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier
        ) as? BasicCell,
        let model = faq?.sections?[indexPath.row]
        else  { return UITableViewCell() }

        cell.configure(model: model, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let faqSection = faq?.sections?[indexPath.row] else { return }
        presenter.goToQuestions(section: faqSection)
    }
}

private let cellIdentifier = "BasicCell"
