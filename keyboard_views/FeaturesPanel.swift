import SwiftUI

struct FeaturesPanel: View {
    var request_subscriber: (String, [String]) -> Void
    
    var body: some View {
        VStack{
            SquareButton(label: "<--", action: {
                (str: String) in
                self.request_subscriber("back", [])
            })
            ButtonsGrid(items: [
                ["Translate", "Correct", "Emoji"],
                ["Expand", "Reply", "Goal"],
                ["Compress", "Paraphrase", "Format"],
                ["Scan", "Tone", "Settings"]
            ], subscriber: {
                (feature: String) in
                self.request_subscriber("state", ["keys + input tool", feature])
            })
        }
    }
}
