import UIKit

class BasicCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    private(set) var basicModel: BasicCellModel?

    func configure(model: BasicCellModel, indexPath: IndexPath) {
        basicModel = model
        model.updateUI(titleLabel: titleLabel, valueLabel: valueLabel, indexPath: indexPath)
    }
}
