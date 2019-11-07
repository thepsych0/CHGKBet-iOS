import UIKit

class FinishRegistrationViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!

    var presenter: AuthorizationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        finishButton.layer.cornerRadius = 12
    }

    @IBAction func finish(_ sender: UIButton) {
        presenter?.goToLine()
    }
}
