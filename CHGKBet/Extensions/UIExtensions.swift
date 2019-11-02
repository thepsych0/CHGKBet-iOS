import UIKit

extension UIButton {
    func enableWithUI(_ newState: Bool) {
        isEnabled = newState
        alpha = newState ? 1 : 0.5
    }
}
