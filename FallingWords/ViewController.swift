import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var newWordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreOk: UILabel!
    @IBOutlet weak var scoreNotOk: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var viewModel: ViewModel!
    var isWordMoving = false
    var userHasAnswered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(languageFrom: .ES, languageTo: .EN)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNewComination()
    }
    
    func showNewComination() {
        self.view.layoutIfNeeded()
        viewModel.setPairOfTranslations(number: 5)
        
        wordToTranslateLabel.text = viewModel.translationToPlay?.get(language: viewModel.languageFrom)
        newWordLabel.text = viewModel.movingTranlation?.get(language: self.viewModel.languageTo)
        
        moveWordDown {
            self.isWordMoving = false
            
            if !self.userHasAnswered {
                self.viewModel.addNonOkPoint()
                self.updateScore()
            }
            self.userHasAnswered = false
        }
    }

    func moveWordDown(completion: @escaping () -> Void) {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.isWordMoving = true
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.maxY + 10)
        }, completion: { finished in
            self.isWordMoving = false
            completion()
        })
    }
    
    func resetInitialPosition() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.minY)
        }, completion: { finished in
        })
    }
    
    func updateScore() {
        userHasAnswered = true
        isWordMoving = false
        scoreOk.text = "\(viewModel.okPoints)/\(viewModel.winScore)"
        scoreNotOk.text = "\(viewModel.nonOkPoints)/\(viewModel.looseScore)"
        resetInitialPosition()
        handleWinLoose()
    }
    
    func handleWinLoose() {
        if viewModel.userHasWin {
            showResult(with: "👏 👌\n You win!")
        } else if viewModel.userHasLost {
            showResult(with: "😭 🤷‍♀️\n Looser!")
        } else {
            showNewComination()
        }
    }
    
    private func showResult(with message: String) {
        resultLabel.text = message
        resultLabel.isHidden = false
        resetButton.isHidden = false
    }

    @IBAction func okPressed(_ sender: Any) {
        viewModel.isCorrectTranslation ? viewModel.addOkPoint() : viewModel.addNonOkPoint()
        updateScore()
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        !viewModel.isCorrectTranslation ? viewModel.addOkPoint() : viewModel.addNonOkPoint()
        updateScore()
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        resultLabel.isHidden = true
        resetButton.isHidden = true
        viewModel.restart()
        updateScore()
    }
}
