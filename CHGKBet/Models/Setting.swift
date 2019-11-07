import UIKit

struct Setting {
    let type: SettingType
    let title: String
    let textColor: UIColor
    let action: (() -> Void)?

    init (type: SettingType, title: String, titleColor: UIColor = .darkGray, action: (() -> Void)? = nil) {
        self.type = type
        self.title = title
        self.textColor = titleColor
        self.action = action
    }

    enum SettingType {
        case info(_ value: String?)
        case navigation
    }
}

extension Setting: BasicCellModel {
    func updateUI(titleLabel: UILabel, valueLabel: UILabel, indexPath: IndexPath) {
        switch self.type {
        case .info(let value):
            titleLabel.text = self.title
            valueLabel.text = value
        case .navigation:
            titleLabel.text = self.title
        }
        titleLabel.textColor = self.textColor
        valueLabel.textColor = self.textColor
        valueLabel.isHidden = valueLabel.text.isNilOrEmpty
    }
}
