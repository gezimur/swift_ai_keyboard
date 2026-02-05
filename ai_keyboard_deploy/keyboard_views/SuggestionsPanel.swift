import SwiftUI

struct SuggestionsPanel: View {
    var request_subscriber: (String, [String]) -> Void
    @State private var suggestions: [String] = []

    var body: some View {
        GeometryReader { geometry in
            let button_width = 0.95 * geometry.size.width / 9
            
            HStack{
                SquareButton(label: "L", icon: "", action: {
                    (str: String) in
                    self.request_subscriber("state", ["keys + features"])
                }, style: .square_accent)
                .frame(width: button_width)
                Spacer()
                HStack{
                    ForEach(suggestions, id: \.self){
                        suggestion in SquareButton(label: suggestion, icon: "", action: {
                            (str: String) in
                            self.request_subscriber("key", [suggestion + " "])
                        }, style: .flat)
                        .frame(width: button_width * 2)
                    }
                }
            }
        }
    }
    
    func setSuggestions(suggestions: [String]) {
        self.suggestions = suggestions
    }
}
