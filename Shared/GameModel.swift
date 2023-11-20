import SwiftUI

class GameModel: ObservableObject {
    @Published var numbers = (1...15).shuffled() + [0]
    @Published var movesCount = 0
    
    func startNewGame() {
        numbers = (1...15).shuffled() + [0]
        movesCount = 0
    }
    
    // Additional game logic functions
}

