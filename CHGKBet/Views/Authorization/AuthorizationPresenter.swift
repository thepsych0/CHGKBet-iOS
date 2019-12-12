import UIKit
import RxSwift

class AuthorizationPresenter {
    
    private let service = UsersService()
    private let disposeBag = DisposeBag()
    
    private var navigationController: UINavigationController?
    private weak var loginViewController: LoginViewController?
    private weak var registrationViewConroller: RegistrationViewController?
    private weak var checkRatingIDViewController: CheckRatingIDViewController?
    private weak var confirmRatingIDViewController: ConfirmRatingIDViewController?
    private weak var finishRegistrationViewController: FinishRegistrationViewController?

    private var currentRatingData: RatingData?
    
    init(loginViewController: LoginViewController?) {
        self.navigationController = loginViewController?.navigationController
        self.loginViewController = loginViewController
    }

    // MARK: Requests
    
    func requestUser(email: String, password: String) {
        service.requestUserInfo(email: email, password: password).subscribe(
            onSuccess: { userInfo in
                User.currentUser = User(credentials: "\(email):\(password)", info: userInfo)
                LinePresenter.present()
            },
            onError: { [weak self] error in
                if let appError = error as? AppError {
                    self?.loginViewController?.showAlertWithOkAction(appError: appError)
                }
            }
        )
        .disposed(by: disposeBag)
    }

    func createUser(email: String, password: String) {
        service.registerUser(email: email, password: password).subscribe(
            onSuccess: { [weak self] userInfo in
                User.currentUser = User(credentials: "\(email):\(password)", info: userInfo)
                self?.goToCheckRatingID()
            },
            onError: { [weak self] error in
                if let appError = error as? AppError {
                    self?.loginViewController?.showAlertWithOkAction(appError: appError)
                }
            }
        )
        .disposed(by: disposeBag)
    }

    func checkRatingID(_ id: String) {
        if id == "0" {
            goToFinishRegistration()
            return
        }
        service.checkRatingID(id)
            .subscribe(
                onSuccess: { [weak self] ratingData in
                    ratingData.id = id
                    self?.currentRatingData = ratingData
                    self?.goToConfirmRatingID(ratingData: ratingData)
                },
                onError: { [weak self] error in
                    if let appError = error as? AppError {
                        self?.loginViewController?.showAlertWithOkAction(appError: appError)
                    }
                }
            )
            .disposed(by: disposeBag)
    }

    func confirmRatingID() {
        guard let id = currentRatingData?.id else { return }
        service.setRatingID(id)
            .subscribe(
                onSuccess: { [weak self] userInfo in
                    User.currentUser?.info = userInfo
                    self?.goToFinishRegistration()
                },
                onError: { [weak self] error in
                    if let appError = error as? AppError {
                        self?.loginViewController?.showAlertWithOkAction(appError: appError)
                    }
                }
            )
            .disposed(by: disposeBag)
    }

    func showHintAlert(senderVC: UIViewController, hint: Hint) {
        let alertController = UIAlertController(
            title: hint.title,
            message: hint.info,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
        senderVC.present(alertController, animated: true)
    }

    // MARK: Routing

    func goToCreateAccount() {
        if let vc = navigationController?.storyboard?.instantiateViewController(
            withIdentifier: "RegistrationViewController"
        ) as? RegistrationViewController {
            registrationViewConroller = vc
            vc.presenter = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func goToCheckRatingID() {
        if let vc = navigationController?.storyboard?.instantiateViewController(
            withIdentifier: "CheckRatingIDViewController"
        ) as? CheckRatingIDViewController {
            checkRatingIDViewController = vc
            vc.presenter = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func goToConfirmRatingID(ratingData: RatingData) {
        if let vc = navigationController?.storyboard?.instantiateViewController(
            withIdentifier: "ConfirmRatingIDViewController"
        ) as? ConfirmRatingIDViewController {
            confirmRatingIDViewController = vc
            vc.ratingData = ratingData
            vc.presenter = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func goToFinishRegistration() {
        if let vc = navigationController?.storyboard?.instantiateViewController(
            withIdentifier: "FinishRegistrationIDViewController"
        ) as? FinishRegistrationViewController {
            finishRegistrationViewController = vc
            vc.presenter = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func goToLine() {
        LinePresenter.present()
    }

    // MARK: Presentation

    static func present() {
        let storyboard = UIStoryboard(name: "Authorization", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            UIApplication.shared.windows.first?.rootViewController = vc
        }
    }

    // MARK: Models

    enum Hint {
        case findID
        case idPurpose
        case noID

        var title: String {
            switch self {
            case .findID:
                return "Как узнать свой ID?"
            case .idPurpose:
                return "Зачем это нужно?"
            case .noID:
                return "Можно ли не вводить ID?"
            }
        }

        var info: String {
            switch self {
            case .findID:
                return "Зайти на сайт рейтинга МАК по ссылке rating.chgk.info и найти себя в разделе игроки, после чего скопировать ID со своей страницы."
            case .idPurpose:
                return "Несмотрия на то, что игра не предполагает ценных призов, хочется не допустить ситуацию, когда высокие результаты достигаются пользователем за счёта регистрации множественных аккаунтов. Также неанонимные ставки упростят в дальнейшем поиск победителей для передачи им призов."
            case .noID:
                return "Если вас нет на сайте рейтинга, или вы по каким-то причинам не хотите сообщать свой ID, то просто введите 0 в поле ввода. Но учтите, что в таком случае ваше имя не будет отображаться в рейтинге лучших аналитиков, и вы не получите призов в конце сезона."
            }
        }
    }
}
