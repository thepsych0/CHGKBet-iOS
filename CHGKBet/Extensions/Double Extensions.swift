import Foundation

extension Double {
    func stringValue(digitsAfterComma: Int = 2) -> String {
        return String(format: "%.2f", self)
    }
}
