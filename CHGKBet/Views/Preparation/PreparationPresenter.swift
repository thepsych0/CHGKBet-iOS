import UIKit
import RxSwift

class PreparationPresenter {
    
    private let service = UsersService()
    private let disposeBag = DisposeBag()

    private weak var preparationViewController: PreparationViewController?

    init(preparationViewController: PreparationViewController) {
        self.preparationViewController = preparationViewController
    }
    
    func checkUser() {
        if let credentials = User.getCredentials() {
            service.requestUserInfo(credentials: credentials)
                .subsribe { result in
                    switch result {
                    case .failure(_):
                        KeychainService.removePassword(service: KeychainService.authService)
                        AuthorizationPresenter.present()
                    case .success(let userInfo):
                        User.currentUser = User(credentials: credentials, info: userInfo)
                        LinePresenter.present()
                    case .none:
                        return
                    }
                }
                .disposed(by: disposeBag)
        } else {
            KeychainService.removePassword(service: KeychainService.authService)
            AuthorizationPresenter.present()
        }
    }

    // MARK: Presentation

    static func present() {
        let storyboard = UIStoryboard(name: "Preparation", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            UIApplication.shared.windows.first?.rootViewController = vc
        }
    }
}
