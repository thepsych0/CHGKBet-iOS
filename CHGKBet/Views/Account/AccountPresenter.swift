import UIKit

class AccountPresenter {

    var navigationController: UINavigationController?
    weak var accountViewController: AccountViewController?

    lazy var settings = [
        Setting(type: .info(User.currentUser?.info.balance.stringValue()), title: "Баланс", action: nil),
        Setting(type: .navigation, title: "История ставок", action: goToBetsHistory),
        Setting(type: .info(getRatingID()), title: "ID на сайте рейтинга", action: nil),
        Setting(type: .info(Bundle.main.version), title: "Версия приложения", action: nil),
        Setting(type: .navigation, title: "Выйти из аккаунта", titleColor: .red, action: logout)
    ]

    init(accountViewController: AccountViewController) {
        self.navigationController = accountViewController.navigationController
        self.accountViewController = accountViewController
    }

    func logout() {
        KeychainService.removePassword(service: KeychainService.authService)
        PreparationPresenter.present()
    }

    func requestSettings() {
        accountViewController?.settings = settings
        if let ratingData = User.currentUser?.info.ratingData {
            accountViewController?.name = "\(ratingData.name ?? "") \(ratingData.surname ?? "")"
        }
    }

    func getRatingID() -> String {
        return User.currentUser?.info.ratingData?.id ?? ""
    }

    func goToBetsHistory() {
        if let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "BetsHistoryViewController") as? BetsHistoryViewController {
            vc.presenter = self
            vc.bets = User.currentUser?.info.bets ?? []
            //eventsViewController = vc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
