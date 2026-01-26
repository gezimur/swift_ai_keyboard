import SwiftUI

struct SuggestionsPanel: View {
    var request_subscriber: (String, [String]) -> Void
    @State private var suggestions: [String] = []

    var body: some View {
        HStack{
            SquareButton(label: "L", icon: "", action: {
                (str: String) in
                self.request_subscriber("state", ["keys + features"])
            }, style: .square_accent)
            .containerRelativeFrame(.horizontal, count: 7, span: 1, spacing: 0.1)
            Spacer()
            HStack{
                ForEach(suggestions, id: \.self){
                    suggestion in SquareButton(label: suggestion, icon: "", action: {
                        (str: String) in
                        self.request_subscriber("key", [suggestion + " "])
                    }, style: .flat)
                    .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0.1)
                }
            }
        }
    }
    
    func setSuggestions(suggestions: [String]) {
        self.suggestions = suggestions
    }
}
