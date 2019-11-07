import UIKit

class EventOptionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coefLabel: UILabel!
    
    var eventOption: EventOption? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        titleLabel.text = eventOption?.title
        if let coef = eventOption?.coef {
            coefLabel.text = String(format: "%.2f", coef)
        }
    }
}
