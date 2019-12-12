import Moya

public protocol BaseAPI: TargetType {
    
    var baseURL: URL { get }
    var sampleData: Data { get }
    var headers: [String : String]? { get }
}

extension BaseAPI {

    var baseURL: URL {
        #if PROD
            return URL(string: "https://chgkbet.vapor.cloud/api")!
        #else
            return URL(string: "https://chgkbet-develop.vapor.cloud/api")!
        #endif
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
    
    func makeHeaders(withAuth: Bool, withClientData: Bool = false, credentials: String? = nil) -> [String: String] {
        let mergeClosure: (String, String) -> String = { first, second in first }

        let clientInfoHeaders: [String: String] = withClientData ?
            ["os": "iOS", "device": UIDevice.current.modelName, "version": "1.03"] :
            [:]

        if !withAuth {
            return standartHeaders.merging(clientInfoHeaders, uniquingKeysWith: mergeClosure)
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
        return ["Authorization": "Basic \(base64LoginString)"]
            .merging(standartHeaders, uniquingKeysWith: mergeClosure)
            .merging(clientInfoHeaders, uniquingKeysWith: mergeClosure)
    }
}
