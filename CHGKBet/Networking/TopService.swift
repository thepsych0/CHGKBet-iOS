import Foundation
import Moya
import RxSwift
import RxRelay

class TopService {

    let provider = MoyaProvider<TopAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()


    func requestPlayers() -> BehavoirRelay<Result<[PlayerInfo], AppError>?> {
        let topPlayers = BehavoirRelay<Result<[PlayerInfo], AppError>?>(defaultValue: nil)

        provider.rx.request(.getTopPlayers).subscribe(
            onSuccess: { response in
                let result: Result<[PlayerInfo], AppError>
                if response.statusCode.isValidStatusCode {
                    if let topPlayersValue = try? self.decoder.decode([PlayerInfo].self, from: response.data) {
                        result = .success(topPlayersValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else {
                    result = .failure(.unknown)
                }
                topPlayers.accept(result)
            },
            onError: { error in
                topPlayers.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)

        return topPlayers
    }
}
