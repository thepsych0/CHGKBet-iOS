import Moya
import RxSwift

class UsersService {
    
    let provider = MoyaProvider<UsersAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()
    
    func requestUserInfo(email: String, password: String) -> Single<UserInfo> {
        return requestUserInfo(credentials: "\(email):\(password)")
    }
    
    func requestUserInfo(credentials: String) -> Single<UserInfo> {
        Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create { } }
            return self.provider.rx.request(.getMe(credentials: credentials)).subscribe(
                onSuccess: { response in
                    if response.statusCode.isValidStatusCode {
                        if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                            observer(SingleEvent.success(userInfoValue))
                        } else {
                            observer(SingleEvent.error(AppError.unknown))
                        }
                    } else if response.statusCode == 401 {
                        observer(SingleEvent.error(AppError.invalidCredentials))
                    } else {
                        observer(SingleEvent.error(AppError.unknown))
                    }
                },
                onError: { error in
                    observer(SingleEvent.error(AppError.unknown))
                }
            )
        }
    }

    func registerUser(email: String, password: String) -> Single<UserInfo> {
        Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create { } }
            return self.provider.rx.request(.register(email: email, password: password)).subscribe(
                onSuccess: { response in
                    if response.statusCode.isValidStatusCode {
                        if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                            observer(SingleEvent.success(userInfoValue))
                        } else {
                            observer(SingleEvent.error(AppError.unknown))
                        }
                    } else {
                        observer(SingleEvent.error(AppError.unknown))
                    }
                },
                onError: { error in
                    observer(SingleEvent.error(AppError.unknown))
                }
            )
        }
    }

    func checkRatingID(_ id: String) -> Single<RatingData> {
        Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create { } }
            return self.provider.rx.request(.checkRatingID(id)).subscribe(
                onSuccess: { response in
                    if response.statusCode.isValidStatusCode {
                        if let ratingDataValue = try? self.decoder.decode(RatingData.self, from: response.data) {
                            observer(SingleEvent.success(ratingDataValue))
                        } else {
                            observer(SingleEvent.error(AppError.unknown))
                        }
                    } else {
                        observer(SingleEvent.error(AppError.unknown))
                    }
                },
                onError: { error in
                    observer(SingleEvent.error(AppError.unknown))
                }
            )
        }
    }

    func setRatingID(_ id: String) -> Single<UserInfo> {
        Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create { } }
            return self.provider.rx.request(.setRatingID(id)).subscribe(
                onSuccess: { response in
                    if response.statusCode.isValidStatusCode {
                        if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                            observer(SingleEvent.success(userInfoValue))
                        } else {
                            observer(SingleEvent.error(AppError.unknown))
                        }
                    } else {
                        observer(SingleEvent.error(AppError.unknown))
                    }
                },
                onError: { error in
                    observer(SingleEvent.error(AppError.unknown))
                }
            )
        }
    }
}
