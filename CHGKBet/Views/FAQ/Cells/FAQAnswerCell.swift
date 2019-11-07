import UIKit

class FAQAnswerCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    var height: CGFloat {
        return answerLabel.frame.height + 30
    }

    var answer: String? {
        didSet {
            answerLabel.text = answer
        }
    }
}
