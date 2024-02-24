import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case green
    case poppy
    case yellow
    
    var accentColor: Color {
        switch self {
        case .green, .poppy, .yellow: return .black
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var id: String {
        name
    }
}
