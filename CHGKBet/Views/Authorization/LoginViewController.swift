import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccounButton: UIButton!
    
    lazy private var presenter = AuthorizationPresenter(loginViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.layer.cornerRadius = 12
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter.requestUser(email: email, password: password)
    }

    @IBAction func createAccount(_ sender: UIButton) {
        presenter.goToCreateAccount()
    }
}
