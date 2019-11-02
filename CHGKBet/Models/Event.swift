import Foundation

struct Event: Codable {
    let id: Int?
    let title: String
    let options: [EventOption]
    let gameID: String
    let tournamentID: Int

    init(id: Int? = nil, title: String, options: [EventOption], gameID: String, tournamentID: Int) {
        self.id = id
        self.title = title
        self.options = options
        self.gameID = gameID
        self.tournamentID = tournamentID
    }
}

struct EventOption: Codable {
    var id: Int?
    var title: String?
    var coef: Double?
}
