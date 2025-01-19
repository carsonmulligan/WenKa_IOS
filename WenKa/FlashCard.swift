import Foundation

struct FlashCard: Codable, Identifiable {
    let scenarioId: String
    let topic: String
    let id: String
    let front: String
    let pinyin: String
    let back: String
    var mastered: Bool
    var masteryLevel: Int
    var correctStreak: Int
}

struct FlashCardData: Codable {
    let flashcards: [FlashCard]
} 