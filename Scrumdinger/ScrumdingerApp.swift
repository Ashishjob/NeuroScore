import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    @State private var isLandingScreenVisible = true
    
    var body: some Scene {
        WindowGroup {
            if isLandingScreenVisible {
                LandingScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isLandingScreenVisible = false
                            }
                        }
                    }
            } else {
                NavigationView {
                    ScrumsView(scrums: $store.scrums) {
                        Task {
                            do {
                                try await store.save(scrums: store.scrums)
                            } catch {
                                errorWrapper = ErrorWrapper(error: error,
                                                            guidance: "Try again later.")
                            }
                        }
                    }
                    .sheet(item: $errorWrapper) {
                        store.scrums = DailyScrum.sampleData
                    } content: { wrapper in
                        ErrorView(errorWrapper: wrapper)
                    }
                }
            }
        }
    }
}

struct LandingScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var animatedText = ""
    private let textToAnimate = "Welcome to NeuroScore."
    private let typingSpeed: TimeInterval = 0.075
    private let lightGray = Color.gray.opacity(0.5)

    var body: some View {
        Text(animatedText)
            .font(.largeTitle)
            .foregroundColor(colorScheme == .dark ? .white : lightGray)
            .onAppear {
                animateText()
            }
    }

    private func animateText() {
        for (index, character) in textToAnimate.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * typingSpeed) {
                animatedText.append(character)
            }
        }
    }
}
