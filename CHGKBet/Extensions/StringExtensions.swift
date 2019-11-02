import Foundation

extension String {
    var doubleValue: Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = "."
        if let value = numberFormatter.number(from: self)?.doubleValue {
            return value
        } else {
            numberFormatter.decimalSeparator = ","
            return numberFormatter.number(from: self)?.doubleValue ?? 0
        }
    }

    mutating func removeZeroes() {
        let baseAmount = self.doubleValue
        var zeroes = 0
        for c in self {
            if c == "0" {
                zeroes += 1
            } else {
                break
            }
        }
        if baseAmount >= 0 && baseAmount < 1 && zeroes > 0 {
            self.removeFirst(zeroes - 1)
        } else {
            self.removeFirst(zeroes)
        }
    }
}


