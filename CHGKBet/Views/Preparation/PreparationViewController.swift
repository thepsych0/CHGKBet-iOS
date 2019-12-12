import UIKit

class PreparationViewController: UIViewController {

    lazy var preparatioPresenter = PreparationPresenter(preparationViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparatioPresenter.checkConditions()
    }
}
