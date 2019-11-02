import Moya

public protocol BaseAPI: TargetType {
    
    var baseURL: URL { get }
    var sampleData: Data { get }
    var headers: [String : String]? { get }
}

extension BaseAPI {

    var baseURL: URL {
        return URL(string: "https://chgkbet-develop.vapor.cloud/api")!
    }
    
    var sampleData: Data {
        return Data()
    }
}

struct BaseResponse<T: Codable>: Codable {
    var success: Bool?
    var data: T?
}

extension BaseAPI {
    
    private var standartHeaders: [String: String] {
        return ["Content-Type": "application/json", "Accept": "application/json"]
    }
    
    func makeHeaders(withAuth: Bool, credentials: String? = nil) -> [String: String] {
        if !withAuth {
            return standartHeaders
        }
        
        let loginString: String
        if let credentials = credentials {
            loginString = credentials
        } else if let credentials = User.currentUser?.credentials {
            loginString = credentials
        } else {
            return standartHeaders
        }
        let loginData = loginString.data(using: .utf8) ?? Data()
        let base64LoginString = loginData.base64EncodedString()
        return ["Authorization": "Basic \(base64LoginString)"].merging(standartHeaders) { first, second in
            return first
        }
    }
}
