import SwiftUI

struct ContentView: View {
    @State private var displayText: String = ""
    
    var body: some View {
        ButtonsGrid(items: [
            ["1", "2", "3",],
            ["4", "5", "6",],
            ["7", "8", "9",],
            ["0"]])
    }
}


