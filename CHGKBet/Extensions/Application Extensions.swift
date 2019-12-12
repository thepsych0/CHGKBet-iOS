import Foundation

extension Bundle {
    var version: String {
        guard let version = infoDictionary?["CFBundleShortVersionString"] as? String else {
            assertionFailure("Could not get version")
            return ""
        }
        return version
    }
}
