import Foundation

class FlashCardViewModel: ObservableObject {
    @Published var flashcards: [FlashCard] = []
    @Published var currentIndex = 0
    @Published var isShowingAnswer = false
    
    init() {
        loadFlashcards()
    }
    
    private func loadFlashcards() {
        guard let url = Bundle.main.url(forResource: "flashcards", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let flashcardData = try? JSONDecoder().decode(FlashCardData.self, from: data) else {
            print("Error loading flashcards")
            return
        }
        
        self.flashcards = flashcardData.flashcards
    }
    
    var currentCard: FlashCard? {
        guard !flashcards.isEmpty else { return nil }
        return flashcards[currentIndex]
    }
    
    func nextCard() {
        isShowingAnswer = false
        currentIndex = (currentIndex + 1) % flashcards.count
    }
    
    func previousCard() {
        isShowingAnswer = false
        currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
    }
    
    func toggleAnswer() {
        isShowingAnswer.toggle()
    }
    
    func markCorrect() {
        guard var card = currentCard else { return }
        card.correctStreak += 1
        card.masteryLevel = min(5, card.masteryLevel + 1)
        card.mastered = card.masteryLevel >= 5
        flashcards[currentIndex] = card
        nextCard()
    }
    
    func markIncorrect() {
        guard var card = currentCard else { return }
        card.correctStreak = 0
        card.masteryLevel = max(1, card.masteryLevel - 1)
        card.mastered = false
        flashcards[currentIndex] = card
        nextCard()
    }
} 