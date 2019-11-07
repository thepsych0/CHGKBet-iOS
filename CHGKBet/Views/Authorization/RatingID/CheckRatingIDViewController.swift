
import UIKit

class CheckRatingIDViewController: UIViewController {

    @IBOutlet weak var checkIDButon: UIButton!
    @IBOutlet weak var ratingIDTextField: UITextField!

    var presenter: AuthorizationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkIDButon.layer.cornerRadius = 12
    }

    @IBAction func checkID(_ sender: UIButton) {
        presenter?.checkRatingID(ratingIDTextField.text!)
    }

    @IBAction func findIDHint() {
        presenter?.showHintAlert(senderVC: self, hint: .findID)
    }

    @IBAction func idPurposeHint() {
        presenter?.showHintAlert(senderVC: self, hint: .idPurpose)
    }

    @IBAction func noIDHint() {
        presenter?.showHintAlert(senderVC: self, hint: .noID)
    }
}
