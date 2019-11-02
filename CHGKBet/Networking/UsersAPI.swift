import Moya

enum UsersAPI {
    case getMe(credentials: String)
}

extension UsersAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMe:
            return "users/me"
        }
    }
    
    var method: Method {
        switch self {
        case .getMe:
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
        case .getMe(let credentials):
            return makeHeaders(withAuth: true, credentials: credentials)
        }
    }
}
