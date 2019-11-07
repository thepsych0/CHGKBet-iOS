import Moya
import RxSwift
import RxRelay

class UsersService {
    
    let provider = MoyaProvider<UsersAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()
    
    func requestUserInfo(email: String, password: String) -> BehavoirRelay<Result<UserInfo, AppError>?> {
        return requestUserInfo(credentials: "\(email):\(password)")
    }
    
    func requestUserInfo(credentials: String) -> BehavoirRelay<Result<UserInfo, AppError>?> {
        let userInfo = BehavoirRelay<Result<UserInfo, AppError>?>(defaultValue: nil)
        
        provider.rx.request(.getMe(credentials: credentials)).subscribe(
            onSuccess: { response in
                let result: Result<UserInfo, AppError>
                if response.statusCode.isValidStatusCode {
                    if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                        result = .success(userInfoValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else if response.statusCode == 401 {
                    result = .failure(.invalidCredentials)
                } else {
                    result = .failure(.unknown)
                }
                userInfo.accept(result)
            },
            onError: { error in
                userInfo.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)
        
        return userInfo
    }

    func registerUser(email: String, password: String) -> BehavoirRelay<Result<UserInfo, AppError>?> {
        let userInfo = BehavoirRelay<Result<UserInfo, AppError>?>(defaultValue: nil)

        provider.rx.request(.register(email: email, password: password)).subscribe(
            onSuccess: { response in
                let result: Result<UserInfo, AppError>
                if response.statusCode.isValidStatusCode {
                    if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                        result = .success(userInfoValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else {
                    result = .failure(.unknown)
                }
                userInfo.accept(result)
            },
            onError: { error in
                userInfo.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)

        return userInfo
    }

    func checkRatingID(_ id: String) -> BehavoirRelay<Result<RatingData, AppError>?> {
        let ratingData = BehavoirRelay<Result<RatingData, AppError>?>(defaultValue: nil)

        provider.rx.request(.checkRatingID(id)).subscribe(
            onSuccess: { response in
                let result: Result<RatingData, AppError>
                if response.statusCode.isValidStatusCode {
                    if let ratingDataValue = try? self.decoder.decode(RatingData.self, from: response.data) {
                        result = .success(ratingDataValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else {
                    result = .failure(.unknown)
                }
                ratingData.accept(result)
            },
            onError: { error in
                ratingData.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)

        return ratingData
    }

    func setRatingID(_ id: String) -> BehavoirRelay<Result<UserInfo, AppError>?> {
        let userInfo = BehavoirRelay<Result<UserInfo, AppError>?>(defaultValue: nil)

        provider.rx.request(.setRatingID(id)).subscribe(
            onSuccess: { response in
                let result: Result<UserInfo, AppError>
                if response.statusCode.isValidStatusCode {
                    if let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data) {
                        result = .success(userInfoValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else {
                    result = .failure(.unknown)
                }
                userInfo.accept(result)
            },
            onError: { error in
                userInfo.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)

        return userInfo
    }
}
