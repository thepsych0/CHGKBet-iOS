import UIKit
import RxSwift

class TopPlayersPresenter {

    let service = TopService()
    let disposeBag = DisposeBag()
    var topPlayers: [PlayerInfo] = []

    var topPlayersViewController: TopPlayersViewController?

    init(topPlayersViewController: TopPlayersViewController) {
        self.topPlayersViewController = topPlayersViewController
    }

    func requestPlayers() {
        service.requestPlayers()
            .subsribe { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let players):
                    self.topPlayers = players
                    self.topPlayersViewController?.players = players
                case .failure(let error):
                    self.topPlayersViewController?.showAlertWithOkAction(appError: error)
                case .none:
                    return
                }
            }
            .disposed(by: disposeBag)
    }
}
