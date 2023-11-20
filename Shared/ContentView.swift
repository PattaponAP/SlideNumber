import SwiftUI

struct ContentView: View {
    @State private var numbers = (1...15).shuffled() + [0]
    @State private var movesCount = 0
    
    var body: some View {
        VStack {
            Text("SlideNumberPuzzleGame :D")
                .font(.largeTitle)
                .foregroundColor(.pink)
            
            newGameButton
            
            numberGrid
                .padding(.vertical)
            
            Text("Moves: \(movesCount)")
                .font(.headline)
                .foregroundColor(.pink)
                .padding(.bottom)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    private var newGameButton: some View {
        Button("New Game") {
            numbers = (1...15).shuffled() + [0]
            movesCount = 0
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.pink)
        .padding(.bottom)
    }
    
    private var numberGrid: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(numbers.indices, id: \.self) { index in
                numberView(for: numbers[index])
                    .onTapGesture {
                        moveNumberIfValid(at: index)
                    }
                    .animation(.default)
            }
        }
        .padding()
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    private func moveNumberIfValid(at index: Int) {
        guard isMoveValid(from: index) else { return }
        
        withAnimation {
            numbers.swapAt(index, numbers.firstIndex(of: 0)!)
            movesCount += 1
        }
    }
    
    private func isMoveValid(from index: Int) -> Bool {
        let row = index / 4
        let column = index % 4
        let emptyIndex = numbers.firstIndex(of: 0)!
        let emptyRow = emptyIndex / 4
        let emptyColumn = emptyIndex % 4
        
        return (row == emptyRow && abs(column - emptyColumn) == 1) || (column == emptyColumn && abs(row - emptyRow) == 1)
    }
    
    private func numberView(for number: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(number == 0 ? .clear : Color.pink)
                .frame(width: 80, height: 80)
                .shadow(radius: number == 0 ? 0 : 5)
            
            if number != 0 {
                Text("\(number)")
                    .font(.title)
                    .foregroundColor(.white)
                    .transition(.scale)
            }
        }
    }
}
