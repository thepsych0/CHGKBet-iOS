import Foundation

struct Event: Codable {
    let id: Int?
    let title: String
    let options: [EventOption]
    let gameID: String
    let tournamentID: Int
    var isAvailable: Bool
}

struct EventOption: Codable {
    var id: Int?
    var title: String?
    var coef: Double?
    var success: Bool?
}
