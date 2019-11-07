import Foundation

class User {
    
    static var currentUser: User?
    
    static func getCredentials() -> String? {
        return KeychainService.loadPassword(service: KeychainService.authService)
    }
    
    var credentials: String? {
        get {
            User.getCredentials()
        }
        set {
            guard let credentials = newValue else { return }
            KeychainService.savePassword(service: KeychainService.authService, data: credentials)
        }
    }
    var info: UserInfo
    
    init(credentials: String, info: UserInfo) {
        self.info = info
        self.credentials = credentials
    }
}

struct UserInfo: Codable {
    var ratingURL: String?
    var ratingData: RatingData?
    var balance: Double
    var bets: [BetHistory]?
}
