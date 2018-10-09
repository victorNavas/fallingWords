import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var newWordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreOk: UILabel!
    @IBOutlet weak var scoreNotOk: UILabel!
    
    var viewModel: ViewModel!
    var isWordMoving = false
    var movingTranlation: Translation?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(languageFrom: .ES, languageTo: .EN)
        wordToTranslateLabel.text = viewModel.translation.get(language: viewModel.languageFrom)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAndRemove(viewModel.getSetOfTranslations(5))
    }
    
    func showAndRemove(_ translations: [Translation]) {
        var translationsToMove = translations
        self.movingTranlation = translationsToMove.first
        self.newWordLabel.text = self.movingTranlation?.get(language: self.viewModel.languageTo)
        
        moveWordDown {
            guard !translationsToMove.isEmpty else {
                return
            }
            translationsToMove.removeFirst()
            print(translationsToMove.count)
            self.resetInitialPosition {
                self.movingTranlation = translationsToMove.first
                self.newWordLabel.text = self.movingTranlation?.get(language: self.viewModel.languageTo)
                self.moveWordDown(completion: {
                    self.showAndRemove(translationsToMove)
                })
            }
        }
    }

    func moveWordDown(completion: @escaping () -> Void) {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.isWordMoving = true
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.maxY + 8)
        }, completion: { finished in
            self.isWordMoving = false
            completion()
        })
    }
    
    func resetInitialPosition(completion: @escaping () -> Void) {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.minY)
        }, completion: { finished in
            self.isWordMoving = false
            completion()
        })
    }

    @IBAction func okPressed(_ sender: Any) {
        if !isWordMoving { return }
//        if translation.text_eng == viewModel.translation.text_eng {
//            //                this is the correct translation!
//        }
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        if !isWordMoving { return }
    }
}

