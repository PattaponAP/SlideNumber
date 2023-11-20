import SwiftUI

struct CardCollection: View {
    @Binding var numbers: [Int]
    @Binding var movesCount: Int
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(numbers.indices, id: \.self) { index in
                NumberCardView(number: numbers[index])
                    .onTapGesture {
                        moveNumberIfValid(at: index)
                    }
                    .animation(.default)
            }
        }
        .padding()
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    private func moveNumberIfValid(at index: Int) {
        guard isMoveValid(from: index) else { return }
        
        withAnimation {
            numbers.swapAt(index, numbers.firstIndex(of: 0)!)
            movesCount += 1
        }
    }
    
    private func isMoveValid(from index: Int) -> Bool {
        // Logic for move validity
    }
}

struct NumberCardView: View {
    let number: Int
    
    var body: some View {
        // Number card view content
    }
}
