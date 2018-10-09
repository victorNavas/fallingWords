import UIKit

enum Languages {
    case EN
    case ES
}

struct Translation: Decodable {
    var text_eng: String
    var text_spa: String
    
    func get(language: Languages) -> String {
        return language == .EN ? text_eng : text_spa
    }
}

class ViewModel {
    
    private var translations: [Translation] = []
    private(set) var languageFrom: Languages!
    private(set) var languageTo: Languages!
    var translation: Translation!
    
    init(languageFrom: Languages, languageTo: Languages) {
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        translations = readWordsFromJson()
        translation = getRandomTranslation()
    }
    
    func getSetOfTranslations(_ number: Int) -> [Translation] {
        var randomTranslations = translations.filter({ $0.text_eng != translation.text_eng})[randomPick: number]
        randomTranslations.append(translation)
        return randomTranslations
    }
    
    private func getRandomTranslation() -> Translation {
        return translations.randomElement() ?? Translation(text_eng: "Error", text_spa: "Error")
    }
    
    private func readWordsFromJson() -> [Translation] {
        var translations: [Translation] = []
        
        if let path = Bundle.main.path(forResource: "words", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let myStructArray = try JSONDecoder().decode([Translation].self, from: data)
                myStructArray.forEach { translations.append($0) }
                return translations

            } catch {
                // handle error
                print("failed")
            }
        }
        return translations
    }
}


extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
