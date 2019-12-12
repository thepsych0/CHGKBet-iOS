import UIKit
import RxSwift

class PreparationPresenter {
    
    private let usersService = UsersService()
    private let appInfoService = AppInfoService()
    private let disposeBag = DisposeBag()

    private weak var preparationViewController: PreparationViewController?

    init(preparationViewController: PreparationViewController) {
        self.preparationViewController = preparationViewController
    }

    func checkConditions() {
        let allChecks = Completable.merge([checkVersion(), checkUser()])
        allChecks.subscribe(
            onCompleted: {
                LinePresenter.present()
            },
            onError: { error in
                if let appError = error as? AppError {
                    switch appError {
                    case .invalidCredentials:
                        AuthorizationPresenter.present()
                    case .versionLessThanMinimum:
                        InsufficientVersionPresenter.present()
                    default:
                        break
                    }
                }
            }
        )
        .disposed(by: disposeBag)
    }

    private func checkVersion() -> Completable {
        Completable.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create {} }
            let userVersion = AppVersion(Bundle.main.version)!
            return self.appInfoService.requestVersions().subscribe(
                onSuccess: { appVersions in
                    guard let minimumVersion = appVersions.appVersionMinimum else {
                        observer(.completed)
                        return
                    }
                    if userVersion >= minimumVersion {
                        observer(.completed)
                    } else {
                        observer(.error(AppError.versionLessThanMinimum))
                    }
                }, onError: { error in
                    observer(.error(error))
                }
            )
        }
    }
    
    private func checkUser() -> Completable {
        return Completable.create { [weak self] observer -> Disposable in
            if let credentials = User.getCredentials() {
                guard let self = self else { return Disposables.create {} }
                return self.usersService.requestUserInfo(credentials: credentials)
                    .subscribe(onSuccess: { userInfo in
                        User.currentUser = User(credentials: credentials, info: userInfo)
                        observer(.completed)
                    },
                    onError: { error in
                        KeychainService.removePassword(service: KeychainService.authService)
                        observer(.error(AppError.invalidCredentials))
                    }
                )
            } else {
                KeychainService.removePassword(service: KeychainService.authService)
                AuthorizationPresenter.present()
                observer(.error(AppError.invalidCredentials))
                return Disposables.create { }
            }
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
