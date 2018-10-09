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
