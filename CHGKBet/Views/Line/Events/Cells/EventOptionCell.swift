import UIKit

class EventOptionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coefLabel: UILabel!
    
    var model: EventOptionCellModel? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let model = model else { return }
        titleLabel.text = model.eventOption.title
        if let coef = model.eventOption.coef {
            coefLabel.text = String(format: "%.2f", coef)
        }
        if let success = model.eventOption.success {
            contentView.backgroundColor = success ? .appGreen : .appRed
        } else {
            contentView.backgroundColor = model.isAvailable ? .white : .lightGray
        }
    }
}

struct EventOptionCellModel {
    let eventOption: EventOption
    let isAvailable: Bool
}
