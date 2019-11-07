import Foundation
import Moya
import RxSwift
import RxRelay

class FAQService {

    let provider = MoyaProvider<FAQAPI>()
    let disposeBag = DisposeBag()
    let decoder = JSONDecoder()


    func requestFAQ() -> BehavoirRelay<Result<FAQ, AppError>?> {
        let faq = BehavoirRelay<Result<FAQ, AppError>?>(defaultValue: nil)

        provider.rx.request(.getFAQ).subscribe(
            onSuccess: { response in
                let result: Result<FAQ, AppError>
                if response.statusCode.isValidStatusCode {
                    if let faqValue = try? self.decoder.decode(FAQ.self, from: response.data) {
                        result = .success(faqValue)
                    } else {
                        result = .failure(.unknown)
                    }
                } else {
                    result = .failure(.unknown)
                }
                faq.accept(result)
            },
            onError: { error in
                faq.accept(.failure(.unknown))
            }
        )
        .disposed(by: disposeBag)

        return faq
    }
}
