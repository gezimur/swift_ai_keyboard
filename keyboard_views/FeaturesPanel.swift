import SwiftUI

class FeaturesPanel: View {
    private var request_subscriber: (String, [String]) -> Void
    var body: some View
    
    init(request_subscriber: (String, [String]) -> Void) {
        self.request_subscriber = request_subscriber

        self.body = {
            VStack{
                SquareButton(label: "Back", action: {
                    (feature: String) -> Void
                    request_subscriber("back", [])
                })
                ButtonsGrid(items: [
                    ["Translate", "Correct", "Emoji"],
                    ["Expand", "Reply", "Goal"],
                    ["Compress", "Paraphrase", "Format"],
                    ["Scan", "Tone", "Settings"]
                ], subscriber: {
                    (feature: String) -> Void
                    request_subscriber("state", [feature])
                })
            }
        }
    }
}