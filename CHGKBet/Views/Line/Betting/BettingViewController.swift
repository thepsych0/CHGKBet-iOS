import UIKit

class BettingViewController: UIViewController {

    @IBOutlet weak var betLabel: UILabel!
    @IBOutlet weak var betInfoView: UIView!
    @IBOutlet weak var confirmBetButton: UIButton!
    @IBOutlet weak var cancelBetButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var betAmountTextField: UITextField!
    @IBOutlet weak var coefficientLabel: UILabel!
    @IBOutlet weak var possiblePayoutLabel: UILabel!
    
    var presenter: LinePresenter?
    var bet: Bet? {
        didSet {
            guard isViewLoaded else { return }
            updateUI()
        }
    }
    var totalAmount: Double? {
        didSet {
            guard isViewLoaded else { return }
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hide))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        confirmBetButton.enableWithUI(false)
        
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    private func updateUI() {
        guard let bet = bet else { return }
        
        configureBetLabel(bet: bet)
        coefficientLabel.text = String(bet.selectedOption.coef ?? 0)
        totalLabel.text = String(totalAmount ?? 0)
    }
    
    private func configureBetLabel(bet: Bet) {
        let optionTitle = bet.selectedOption.title ?? ""
        let attributedText = NSMutableAttributedString(string: "\(bet.event.title): \(optionTitle)")
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: betLabel.font.pointSize, weight: .semibold),
            range: NSRange(location: attributedText.string.count - optionTitle.count, length: optionTitle.count)
        )
        betLabel.attributedText = attributedText
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        betInfoView.layer.cornerRadius = 12
        confirmBetButton.layer.cornerRadius = 8
        cancelBetButton.layer.cornerRadius = 8
        cancelBetButton.layer.borderWidth = 1
        cancelBetButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func cancel() {
        hide()
    }
    
    @IBAction func confirm() {
        guard var bet = bet else { return }
        bet.amount = betAmountTextField.text?.doubleValue
        presenter?.makeBet(bet)
    }
    
    @objc func hide() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func betAmountChanged(_ sender: Any) {
        guard let text = betAmountTextField.text, let bet = bet, let coef = bet.selectedOption.coef else { return }
        betAmountTextField.text?.removeZeroes()
        confirmBetButton.enableWithUI(!text.isEmpty && text.doubleValue > 0)
        possiblePayoutLabel.text = String(text.doubleValue * coef)
    }
}

extension BettingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: view)
        return point.x <= betInfoView.frame.minX || point.x >= betInfoView.frame.maxX || point.y <= betInfoView.frame.minY || point.y >= betInfoView.frame.maxY
    }
}
