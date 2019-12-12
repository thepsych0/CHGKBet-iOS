enum AppError: Error {
    case invalidCredentials
    case unknown
    case passwordsDontMatch
    case invalidEmail
    case versionLessThanMinimum
    case custom(title: String, message: String?)

    var title: String? {
        switch self {
        case .invalidCredentials:
            return "Пользователь с такими данными не найден"
        case .unknown:
            return "Неизвестная ошибка"
        case .passwordsDontMatch:
            return "Введённые пароли не совпадают"
        case .invalidEmail:
            return "Не удалось валидировать email"
        case .versionLessThanMinimum:
            return "Версия вашего приложения устарела"
        case .custom(let title, _):
            return title
        }
    }

    var message: String? {
        switch self {
        case .unknown:
            return "Попробуйте повторить запрос позже"
        case .invalidEmail:
            return "Пожалуйста, введите корректный email и повторите попытку"
        case .custom(_, let message):
            return message
        default:
            return nil
        }
    }
}

extension Int {
    var isValidStatusCode: Bool {
        return self >= 200 && self < 300
    }
}
