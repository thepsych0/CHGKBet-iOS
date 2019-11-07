import UIKit

struct PlayerInfo: Codable {
    let ratingData: RatingData?
    let balance: Double?
}

extension PlayerInfo: BasicCellModel {
    func updateUI(titleLabel: UILabel, valueLabel: UILabel, indexPath: IndexPath) {
        let fullName = "\(indexPath.row + 1). \(self.ratingData?.name ?? "") \(self.ratingData?.surname ?? "")"
        titleLabel.text = fullName
        valueLabel.text = String(format: "%.2f", self.balance ?? 0)
    }
}
