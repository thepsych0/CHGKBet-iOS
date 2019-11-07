import UIKit
import RxSwift

class FAQPresenter {

    var navigationController: UINavigationController?
    weak var faqSectionsViewController: FAQSectionsViewController?
    weak var faqQuestionsViewController: FAQQuestionsViewController?

    let service = FAQService()
    let disposeBag = DisposeBag()

    var faq: FAQ?

    init(faqSectionsViewController: FAQSectionsViewController) {
        navigationController = faqSectionsViewController.navigationController
        self.faqSectionsViewController = faqSectionsViewController
    }

    func requestFAQ() {
        service.requestFAQ()
            .subsribe { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let faq):
                    self.faq = faq
                    self.faqSectionsViewController?.faq = faq
                case .failure(let error):
                    self.faqSectionsViewController?.showAlertWithOkAction(appError: error)
                case .none:
                    return
                }
            }
            .disposed(by: disposeBag)
    }

    func goToQuestions(section: FAQ.Section) {
        if let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: "FAQQuestionsViewController") as? FAQQuestionsViewController {
            vc.presenter = self
            vc.faqSection = section
            faqQuestionsViewController = vc
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
