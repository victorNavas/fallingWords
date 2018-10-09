import UIKit

class ViewModel {
    
    private var translations: [Translation] = []
    private(set) var languageFrom: Languages!
    private(set) var languageTo: Languages!
    
    var translationToPlay: Translation?
    var movingTranlation: Translation?
    
    private(set) var okPoints = 0
    private(set) var nonOkPoints = 0
    
    private(set) var winScore = 10
    private(set) var looseScore = 3
    
    var isCorrectTranslation: Bool {
        return movingTranlation?.text_eng == translationToPlay?.text_eng
    }
    
    init(languageFrom: Languages, languageTo: Languages) {
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        translations = readWordsFromJson()
    }
    
    func setTranslationToPlay() {
        translationToPlay = translations.randomElement()
    }
    
    func setMovingTranslation(number: Int) {
        movingTranlation = getRandomTranslations(number).randomElement()
    }
    
    func getRandomTranslations(_ number: Int) -> [Translation] {
        guard let translation = translationToPlay else { return [] }
        var randomTranslations = translations.filter({ $0.text_eng != translation.text_eng})[randomPick: number]
        randomTranslations.append(translation)
        return randomTranslations
    }
    
    func addOkPoint() {
        okPoints += 1
    }
    
    func addNonOkPoint() {
        nonOkPoints += 1
    }
    
    func userHasWin() -> Bool {
        return okPoints >= winScore
    }
    
    func userHasLost() -> Bool {
        return nonOkPoints >= looseScore
    }
    
    func restart() {
        okPoints = 0
        nonOkPoints = 0
    }
    
    private func readWordsFromJson() -> [Translation] {
        var translations: [Translation] = []
        
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            // TODO: remove this force try, for the shake of time we test this manually
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let myStructArray = try! JSONDecoder().decode([Translation].self, from: data)
            myStructArray.forEach { translations.append($0) }
            return translations
        }
        return translations
    }
}
