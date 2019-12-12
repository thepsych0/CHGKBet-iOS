import UIKit

extension UIViewController {
    func showAlert(
        appError: AppError,
        actions: [UIAlertAction] = []
    ) {
        let alertController = UIAlertController(
            title: appError.title,
            message: appError.message,
            preferredStyle: .alert
        )
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true)
    }

    func showAlertWithOkAction(appError: AppError) {
        let alertController = UIAlertController(title: appError.title, message: appError
            .message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alertController, animated: true)
    }

    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
