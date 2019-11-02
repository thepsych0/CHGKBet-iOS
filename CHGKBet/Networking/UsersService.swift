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
                print(error)
            }
        )
        .disposed(by: disposeBag)
        
        return userInfo
    }
}

enum AppError: Error {
    case invalidCredentials
    case unknown
    case custom(title: String, message: String)
}

extension Int {
    var isValidStatusCode: Bool {
        return self >= 200 && self < 300
    }
}
