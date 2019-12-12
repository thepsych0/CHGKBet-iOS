import UIKit

class BetHistoryCell: UITableViewCell {

    @IBOutlet weak var tournamentLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var betOptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var possiblePayoutLabel: UILabel!

    var bet: BetHistory? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        guard let bet = bet else { return }
        tournamentLabel.text = bet.tournament.title ?? ""
        eventLabel.text = bet.event.title
        betOptionLabel.text = bet.selectedOptionTitle

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateFormatter.string(from: bet.convertedDate)

        amountLabel.text = String(format: "%.2f", bet.amount)

        let optionCoef = bet.event.options.first { $0.title == bet.selectedOptionTitle }?.coef ?? 0
        possiblePayoutLabel.text = String(format: "%.2f", bet.amount * optionCoef)

        if let success = bet.success {
            possiblePayoutLabel.textColor = success ? .appGreen : .appRed
        } else {
            possiblePayoutLabel.textColor = .darkGray
        }
    }
}
