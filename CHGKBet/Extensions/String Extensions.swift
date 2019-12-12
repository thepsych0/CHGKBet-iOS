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

    var isValidEmail: Bool {
        let regex = try! NSRegularExpression(pattern: "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
        "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

