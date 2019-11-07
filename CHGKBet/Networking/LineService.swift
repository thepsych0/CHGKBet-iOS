import Foundation
import RxSwift
import RxRelay
import Moya

class LineService {
    
    let provider = MoyaProvider<LineAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()
    
    func requestTournaments() -> BehavoirRelay<[Tournament]?> {
        let tournaments: BehavoirRelay<[Tournament]?> = BehavoirRelay(defaultValue: nil)
        
        provider.rx.request(.getTournaments).subscribe(
            onSuccess: { response in
                let tournamentsValue = try? self.decoder.decode([Tournament].self, from: response.data)
                tournaments.accept(tournamentsValue)
            },
            onError: { error in
                print(error)
            }
        )
        .disposed(by: disposeBag)
        
        return tournaments
    }
    
    func requestGamesInfo(ids: [String]) -> BehavoirRelay<[GameInfo]> {
        let gamesInfo: BehavoirRelay<[GameInfo]> = BehavoirRelay(defaultValue: [])
        
        provider.rx.request(.getGames(ids: ids)).subscribe(
            onSuccess: { response in
                let gamesInfoDict = try? self.decoder.decode([String: GameInfo].self, from: response.data)
                gamesInfo.accept(ids.compactMap { gamesInfoDict?[$0] })
            },
            onError: { error in
                print(error)
            }
        )
        .disposed(by: disposeBag)
        
        return gamesInfo
    }
    
    func requestEvents(tournamentID: Int, gameID: String) -> BehavoirRelay<[Event]?> {
        let events: BehavoirRelay<[Event]?> = BehavoirRelay(defaultValue: nil)
        
        provider.rx.request(.getEvents(tournamentID: tournamentID, gameID: gameID)).subscribe(
            onSuccess: { response in
                let eventsValue = try? self.decoder.decode([Event].self, from: response.data)
                events.accept(eventsValue)
            },
            onError: { error in
                print(error)
            }
        )
        .disposed(by: disposeBag)
        
        return events
    }
    
    func makeBet(bet: Bet) -> BehavoirRelay<UserInfo?> {
        let newUserInfo: BehavoirRelay<UserInfo?> = BehavoirRelay(defaultValue: nil)
        
        provider.rx.request(.makeBet(bet: bet)).subscribe(
            onSuccess: { response in
                let userInfoValue = try? self.decoder.decode(UserInfo.self, from: response.data)
                newUserInfo.accept(userInfoValue)
            },
            onError: { error in
                print(error)
            }
        )
        .disposed(by: disposeBag)
        
        return newUserInfo
    }
}
