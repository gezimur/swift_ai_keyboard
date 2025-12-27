import SwiftUI

struct SuggestionsPanel: View {
    var request_subscriber: (String, [String]) -> Void
    @State private var suggestions: [String] = [""]

    var body: some View {
        HStack{
            SquareButton(label: "L", action: {
                (str: String) in
                self.request_subscriber("state", ["keys + features"])
            })
            Spacer()
            HStack{
                ForEach(suggestions, id: \.self){
                    suggestion in SquareButton(label: suggestion, action: {
                        (str: String) in
                        self.request_subscriber("key", [suggestion + " "])
                    })
                }
            }
        }
    }
    
    func setSuggestions(suggestions: [String]) {
        self.suggestions = suggestions
    }
}
