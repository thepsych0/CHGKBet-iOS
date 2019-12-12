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
        guard let tournament = tournament else { return }

        titleLabel.text = tournament.title
        
        if let date = tournament.convertedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            var dateText = dateFormatter.string(from: date)
            if tournament.isOver ?? false {
                dateText += ", завершён"
                dateLabel.textColor = .darkGray
            } else {
                dateLabel.textColor = .appGreen
            }
            dateLabel.text = dateText
            if let logoURL = tournament.logoURL {
                logoImageView.download(from: logoURL)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.layer.cornerRadius = logoImageView.frame.height / 2
    }
}

extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
