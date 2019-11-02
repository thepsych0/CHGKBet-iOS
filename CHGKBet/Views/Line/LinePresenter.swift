import UIKit
import RxSwift

class LinePresenter {
    private let navigationController: UINavigationController?
    private weak var tournamentsViewController: TournamentsViewController?
    private weak var gamesViewController: GamesViewController?
    private weak var eventsViewController: EventsViewController?
    private weak var bettingViewController: BettingViewController?
    private let disposeBag = DisposeBag()
    private lazy var storyboard = navigationController?.storyboard
    
    private var selectedTournament: Tournament?
    private var selectedGame: GameInfo?
    private var bet: Bet?
    
    private let service = LineService()
    
    init(tournamentsViewController: TournamentsViewController?) {
        self.navigationController = tournamentsViewController?.navigationController
        self.tournamentsViewController = tournamentsViewController
    }
    
    // MARK: Requests
    
    func requestTournaments() {
        service.requestTournaments()
            .subsribe { [weak self] tournaments in
                guard let self = self, let tournaments = tournaments else { return }
            
                self.tournamentsViewController?.tournaments = tournaments
            }
            .disposed(by: disposeBag)
    }
    
    func requestGames() {
        guard let tournament = selectedTournament, let gamesIDs = tournament.games else { return }
        service.requestGamesInfo(ids: gamesIDs)
            .subsribe { [weak self] games in
                guard let self = self else { return }
                
                self.gamesViewController?.games = games
            }
            .disposed(by: disposeBag)
    }
    
    func requestEvents() {
        guard let tournamentID = selectedTournament?.id,
            let gameID = selectedGame?.id
            else { return }
        service.requestEvents(tournamentID: tournamentID, gameID: gameID)
            .subsribe { [weak self] events in
                guard let self = self, let events = events else { return }

                self.eventsViewController?.events = events.sorted(by: { $0.id ?? 0 > $1.id ?? 0 })
            }
            .disposed(by: disposeBag)
    }
    
    func makeBet(_ bet: Bet) {
        service.makeBet(bet: bet)
            .subsribe { [weak self] success in
                guard let self = self, let success = success else { return }
                
                if success {
                    self.bettingViewController?.showAcceptedView()
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Router
    
    func goToGames(tournament: Tournament) {
        selectedTournament = tournament
        if let vc = storyboard?.instantiateViewController(withIdentifier: "GamesViewController") as? GamesViewController {
            vc.presenter = self
            gamesViewController = vc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToEvents(game: GameInfo) {
        selectedGame = game
        if let vc = storyboard?.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController {
            vc.presenter = self
            eventsViewController = vc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToBetting(bet: Bet) {
        self.bet = bet
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BettingViewController") as? BettingViewController {
            vc.presenter = self
            vc.bet = bet
            vc.totalAmount = User.currentUser?.info.balance
            bettingViewController = vc
            navigationController?.topViewController?.present(vc, animated: true)
        }
    }
    
    // MARK: Presentation
    
    static func present() {
        let storyboard = UIStoryboard(name: "Line", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() {
            UIApplication.shared.windows.first?.rootViewController = vc
        }
    }
}
