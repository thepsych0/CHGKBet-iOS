import UIKit
import RxSwift

class AuthorizationPresenter {
    
    private let service = UsersService()
    private let disposeBag = DisposeBag()
    
    var navigationController: UINavigationController?
    weak var loginViewController: LoginViewController?
    
    init(loginViewController: LoginViewController?) {
        self.navigationController = loginViewController?.navigationController
        self.loginViewController = loginViewController
    }
    
    func requestUser(email: String, password: String) {
        service.requestUserInfo(email: email, password: password)
            .subsribe { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userInfo):
                    User.currentUser = User(credentials: "\(email):\(password)", info: userInfo)
                    LinePresenter.present()
                case .none:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
}
