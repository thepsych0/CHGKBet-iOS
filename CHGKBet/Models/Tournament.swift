import UIKit

struct Tournament: Codable {
    let id: Int?
    let title: String?
    private let date: Double?
    var convertedDate: Date? {
        guard let date = date else { return nil }
        return Date(timeIntervalSince1970: date)
    }
    let games: [String]?
}
