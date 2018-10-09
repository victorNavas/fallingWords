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
    
    var movingTranlation: Translation?
    var isCorrectTranslation: Bool {
        return movingTranlation?.text_eng == viewModel.translation.text_eng
    }

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
        viewModel.setRandomTranslation()
        wordToTranslateLabel.text = viewModel.translation.get(language: viewModel.languageFrom)
        movingTranlation = viewModel.getSetOfTranslations(5).randomElement()
        newWordLabel.text = movingTranlation?.get(language: self.viewModel.languageTo)
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
        
        if viewModel.userHasWin() {
            resultLabel.text = "👏 👌\n You win!"
            resultLabel.isHidden = false
            resetButton.isHidden = false
        } else if viewModel.userHasLost() {
            resultLabel.text = "😭 🤷‍♀️\n Looser!"
            resultLabel.isHidden = false
            resetButton.isHidden = false
        } else {
            showNewComination()
        }
    }

    @IBAction func okPressed(_ sender: Any) {
        isCorrectTranslation ? viewModel.addOkPoint() : viewModel.addNonOkPoint()
        updateScore()
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        !isCorrectTranslation ? viewModel.addOkPoint() : viewModel.addNonOkPoint()
        updateScore()
    }
    
    @IBAction func restartPressed(_ sender: Any) {
        resultLabel.isHidden = true
        resetButton.isHidden = true
        viewModel.restart()
        updateScore()
    }
}

