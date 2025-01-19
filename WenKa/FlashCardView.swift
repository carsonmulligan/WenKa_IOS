import SwiftUI

struct FlashCardView: View {
    @StateObject private var viewModel = FlashCardViewModel()
    @State private var cardRotation = 0.0
    @State private var contentRotation = 0.0
    
    var body: some View {
        VStack {
            if let card = viewModel.currentCard {
                // Progress indicator
                ProgressView(value: Double(viewModel.currentIndex + 1), total: Double(viewModel.flashcards.count))
                    .padding()
                    .tint(.blue)
                
                Spacer()
                
                // Topic header
                Text(card.topic)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                // Card
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 10)
                    
                    VStack(spacing: 20) {
                        if !viewModel.isShowingAnswer {
                            Text(card.front)
                                .font(.title)
                                .multilineTextAlignment(.center)
                            
                            Text(card.pinyin)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        } else {
                            Text(card.back)
                                .font(.title)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(30)
                }
                .frame(height: 300)
                .rotation3DEffect(.degrees(cardRotation), axis: (x: 0, y: 1, z: 0))
                .padding()
                .onTapGesture {
                    withAnimation(.spring()) {
                        cardRotation += 180
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            viewModel.toggleAnswer()
                        }
                    }
                }
                
                Spacer()
                
                // Control buttons
                HStack(spacing: 40) {
                    Button(action: { viewModel.markIncorrect() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                    }
                    
                    Button(action: { viewModel.markCorrect() }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    }
                }
                .padding()
                
                // Navigation buttons
                HStack {
                    Button(action: viewModel.previousCard) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    // Mastery level indicator
                    HStack {
                        ForEach(0..<5) { index in
                            Image(systemName: index < card.masteryLevel ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: viewModel.nextCard) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title)
                    }
                }
                .padding()
            } else {
                Text("No flashcards available")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
} 