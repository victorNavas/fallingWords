import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var newWordLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var isWordMoving = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        moveWordDown()
    }

    func moveWordDown() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.isWordMoving = true
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.maxY + 8)
        }, completion: { finished in
            
            self.resetInitialPosition()
        })
    }
    
    func resetInitialPosition() {
        if isWordMoving { return }
        
        UIView.animate(withDuration: 0.0, delay: 0.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            self.newWordLabel.center = CGPoint(x: self.containerView.frame.midX, y: self.containerView.frame.minY)
        }, completion: { finished in
//            self.moveWordDown()
        })
    }

    @IBAction func okPressed(_ sender: Any) {
        if !isWordMoving { return }
    }
    
    @IBAction func notOkPressed(_ sender: Any) {
        if !isWordMoving { return }
    }
}

