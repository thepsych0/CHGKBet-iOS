import Moya

enum LineAPI {
    case getTournaments
    case getGames(ids: [String])
    case getEvents(tournamentID: Int, gameID: String)
    case makeBet(bet: Bet)
}

extension LineAPI: BaseAPI {
    var path: String {
        switch self {
        case .getTournaments:
            return "tournaments"
        case .getGames:
            return "games"
        case .getEvents(let tournamentID, let gameID):
            return "events/\(tournamentID)/\(gameID)"
        case .makeBet:
            return "bets"
        }
    }
    
    var method: Method {
        switch self {
        case .getEvents, .getGames, .getTournaments:
            return .get
        case .makeBet:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getGames(let ids):
            let parameters = ["ids": ids]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .makeBet(let bet):
            let parameters:[String: Any] = [
                "eventID": bet.event.id ?? 0,
                "selectedOptionTitle": bet.selectedOption.title ?? "",
                "amount": bet.amount ?? 0
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .makeBet:
            return makeHeaders(withAuth: true)
        default:
            return makeHeaders(withAuth: false)
        }
    }
}
