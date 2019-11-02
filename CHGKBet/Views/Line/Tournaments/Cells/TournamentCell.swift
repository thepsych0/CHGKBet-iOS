import UIKit

class TournamentCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tournament: Tournament? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = tournament?.title
        
        if let date = tournament?.convertedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
}
