import Moya

enum FAQAPI {
    case getFAQ
}

extension FAQAPI: BaseAPI {
    var path: String {
        switch self {
        case .getFAQ:
            return "faq"
        }
    }

    var method: Method {
        switch self {
        case .getFAQ:
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

