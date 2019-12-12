import UIKit

class InsufficientVersionPresenter {

    func openAppUpdate() {
        guard let url = URL(string: "https://chgkbet-develop.vapor.cloud/install-ios") else { return }
        UIApplication.shared.open(url)
    }

    static func present() {
        let storyboard = UIStoryboard(name: "InsufficientVersion", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            UIApplication.shared.windows.first?.rootViewController = vc
        }
    }
}
