import Foundation
import Moya
import RxSwift

class AppInfoService {

    let provider = MoyaProvider<AppInfoAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()


    func requestVersions() -> Single<AppVersions> {
        Single.create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create { } }
            return self.provider.rx.request(.getVersions).subscribe(
                onSuccess: { response in
                    if response.statusCode.isValidStatusCode {
                        if let versions = try? self.decoder.decode(AppVersions.self, from: response.data) {
                            observer(SingleEvent.success(versions))
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
