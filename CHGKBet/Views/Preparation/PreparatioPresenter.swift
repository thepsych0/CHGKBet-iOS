import UIKit
import RxSwift

class PreparatioPresenter {
    
    private let service = UsersService()
    private let disposeBag = DisposeBag()
    
    func checkUser() {
        if let credentials = User.getCredentials() {
            service.requestUserInfo(credentials: credentials)
                .subsribe { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let userInfo):
                        User.currentUser = User(credentials: credentials, info: userInfo)
                        LinePresenter.present()
                    case .none:
                        return
                    }
                }
                .disposed(by: disposeBag)
        }
    }
}
