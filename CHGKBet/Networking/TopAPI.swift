import Moya

enum TopAPI {
    case getTopPlayers
}

extension TopAPI: BaseAPI {
    var path: String {
        switch self {
        case .getTopPlayers:
            return "top"
        }
    }

    var method: Method {
        switch self {
        case .getTopPlayers:
            return .get
        }
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        default:
            return makeHeaders(withAuth: false)
        }
    }
}

