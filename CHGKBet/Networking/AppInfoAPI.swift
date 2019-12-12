import Moya

enum AppInfoAPI {
    case getVersions
}

extension AppInfoAPI: BaseAPI {
    var path: String {
        switch self {
        case .getVersions:
            return "get-versions"
        }
    }

    var method: Method {
        switch self {
        case .getVersions:
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
            return makeHeaders(withAuth: false, withClientData: true)
        }
    }
}

