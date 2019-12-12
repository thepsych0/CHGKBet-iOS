import Moya

enum UsersAPI {
    case getMe(credentials: String)
    case register(email: String, password: String)
    case checkRatingID(_ id: String)
    case setRatingID(_ id: String)
}

extension UsersAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMe:
            return "users/me"
        case .register:
            return "users/register"
        case .checkRatingID(let id):
            return "users/rating/checkID/\(id)"
        case .setRatingID(let id):
            return "users/rating/setID/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .getMe, .checkRatingID:
            return .get
        case .register, .setRatingID:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .register(let email, let password):
            let parameters = ["email": email, "password": password]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMe(let credentials):
            return makeHeaders(withAuth: true, withClientData: true, credentials: credentials)
        case .register, .checkRatingID:
            return makeHeaders(withAuth: false)
        case .setRatingID:
            return makeHeaders(withAuth: true)
        }
    }
}
