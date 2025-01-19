import SwiftUI

@main
struct WenKaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FlashCardView()
                    .navigationTitle("WenKa")
            }
        }
    }
} 