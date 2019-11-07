import Foundation

struct Bet: Codable {
    let event: Event
    let selectedOptionIndex: Int
    var selectedOption: EventOption {
        return event.options[selectedOptionIndex]
    }
    var amount: Double?
}

struct BetHistory: Codable {
    let id: Int?
    let selectedOptionTitle: String
    let amount: Double
    let success: Bool?
    let date: Double
    var convertedDate: Date {
        return Date(timeIntervalSince1970: date)
    }
    let tournament: Tournament
    let event: Event
}
