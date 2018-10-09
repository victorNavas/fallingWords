import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var newWordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scoreOk: UILabel!
    @IBOutlet weak var scoreNotOk: UILabel!
    
    var viewModel: ViewModel!
    var isWordMoving = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(languageFrom: .ES, languageTo: .EN)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
//        viewModel.readWordsFromJson()
        
        moveWordDown()
    }

    func moveWordDown() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.isWordMoving = true
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.maxY + 8)
        }, completion: { finished in
            self.isWordMoving = false
            self.resetInitialPosition()
        })
    }
    
    func resetInitialPosition() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.minY)
        }, completion: { finished in
            self.isWordMoving = false
            self.moveWordDown()
        })
    }

    @IBAction func okPressed(_ sender: Any) {
        if !isWordMoving { return }
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        if !isWordMoving { return }
    }
}

