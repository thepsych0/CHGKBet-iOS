import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    var presenter: AuthorizationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registerButton.layer.cornerRadius = 12
    }

    @IBAction func register(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirmance = confirmPasswordTextField.text
            else { return }
        guard email.isValidEmail else {
            showAlertWithOkAction(appError: .invalidEmail)
            return
        }
        guard password == passwordConfirmance else {
            showAlertWithOkAction(appError: .passwordsDontMatch)
            passwordTextField.text = ""
            confirmPasswordTextField.text = ""
            return
        }
        presenter?.createUser(email: email, password: password)
    }
}
