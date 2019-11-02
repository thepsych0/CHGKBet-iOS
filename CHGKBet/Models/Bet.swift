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
    let eventID: Int?
    let optionTitle: String?
    let amount: Double?
}
