import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var game: GameInfo? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        titleLabel.text = game?.title
        infoLabel.text = game?.additionalInfo
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
}
