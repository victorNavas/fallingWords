import UIKit

enum Languages {
    case EN
    case ES
}

struct Translation: Decodable {
    var text_eng: String
    var text_spa: String
}

class ViewModel {
    
    var translations: [Translation] = []
    private(set) var languageFrom: Languages!
    private(set) var languageTo: Languages!
    
    init(languageFrom: Languages, languageTo: Languages) {
        self.languageFrom = languageFrom
        self.languageTo = languageTo
        translations = readWordsFromJson()
    }
    
    func getRandomTranslation() -> Translation {
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
