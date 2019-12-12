import UIKit

class InsufficientVersionViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!

    let presenter = InsufficientVersionPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateButton.layer.cornerRadius = 12
    }

    @IBAction func update() {
        presenter.openAppUpdate()
    }
}
