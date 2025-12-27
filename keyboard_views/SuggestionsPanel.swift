import SwiftUI

class SuggestionsPanel: View {
    private var request_subscriber: (String, [String]) -> Void
    @state private var suggestions: [String] = [""]
    var body: some View 
    
    init(request_subscriber: (String, [String]) -> Void) {
        self.request_subscriber = request_subscriber

        self.body = VStack{
            SquareButton(label: "<--", action: {
                request_subscriber("back", [])
            })
            HStack{
                ForEach(suggestions, id: \.self){
                    suggestion in SquareButton(label: suggestion, action: {
                        request_subscriber("key", [suggestion + " "])
                    })
                }
            }
        }
    }

    func setSuggestions(suggestions: [String]) {
        self.suggestions = suggestions
    }
}