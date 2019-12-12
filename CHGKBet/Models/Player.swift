import UIKit

struct PlayerInfo: Codable {
    let name: String?
    let balance: Double?
}

extension PlayerInfo: BasicCellModel {
    func updateUI(titleLabel: UILabel, valueLabel: UILabel, indexPath: IndexPath) {
        let fullName = "\(indexPath.row + 1). \(name ?? "")"
        titleLabel.text = fullName
        valueLabel.text = String(format: "%.2f", self.balance ?? 0)
    }
}
