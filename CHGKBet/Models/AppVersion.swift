import Foundation

struct AppVersion {
    let firstDigit: Int
    let secondDigit: Int

    init?(_ string: String) {
        let digits = string.split(separator: ".")
        guard digits.count == 2, let firstDigit = Int(digits[0]), let secondDigit = Int(digits[1]) else {
            return nil
        }
        self.firstDigit = firstDigit
        self.secondDigit = secondDigit
    }
}

struct AppVersions: Codable {
    private let appVersionCurrentString: String?
    private let appVersionMinimumString: String?

    var appVersionCurrent: AppVersion? {
        guard let appVersionCurrentString = appVersionCurrentString else { return nil }
        return AppVersion(appVersionCurrentString)
    }

    var appVersionMinimum: AppVersion? {
        guard let appVersionMinimumString = appVersionMinimumString else { return nil }
        return AppVersion(appVersionMinimumString)
    }

    enum CodingKeys: String, CodingKey {
        case appVersionCurrentString = "appVersionCurrent"
        case appVersionMinimumString = "appVersionMinimum"
    }
}

extension AppVersion: Comparable {
    static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
        if lhs.firstDigit == rhs.firstDigit {
            return lhs.secondDigit < rhs.secondDigit
        } else {
            return lhs.firstDigit < rhs.firstDigit
        }
    }

    static func == (lhs: AppVersion, rhs: AppVersion) -> Bool {
        return lhs.firstDigit == rhs.firstDigit && lhs.secondDigit == rhs.secondDigit
    }
}
