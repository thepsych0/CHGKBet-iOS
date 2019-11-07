import UIKit

struct FAQ: Codable {
    var sections: [Section]?

    struct Section: Codable {
        var title: String
        var questions: [Question]
    }

    struct Question: Codable {
        var question: String?
        var answer: String?
    }
}

extension FAQ.Section: BasicCellModel {
    func updateUI(titleLabel: UILabel, valueLabel: UILabel, indexPath: IndexPath) {
        titleLabel.text = title
    }
}
