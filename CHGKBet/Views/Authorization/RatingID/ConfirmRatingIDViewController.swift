import UIKit

class ConfirmRatingIDViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!

    var presenter: AuthorizationPresenter?
    var ratingData: RatingData? {
        didSet {
            if isBeingPresented {
                updateUI()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    func updateUI() {
        guard let ratingData = ratingData else { return }
        nameLabel.text = "\(ratingData.name ?? "") \(ratingData.patronymic ?? "") \(ratingData.surname ?? "")"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        yesButton.layer.cornerRadius = 12
        noButton.layer.cornerRadius = 8
        noButton.layer.borderWidth = 1
        noButton.layer.borderColor = UIColor.darkGray.cgColor
    }

    @IBAction func retry(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func finish(_ sender: UIButton) {
        presenter?.confirmRatingID()
    }
}
