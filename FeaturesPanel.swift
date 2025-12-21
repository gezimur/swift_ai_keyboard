import SwiftUI

struct FeaturesPanel: View {
    let prev_state: String
    let state_subscriber: (String) -> Void
    
    var body: some View {
        VStack{
            SquareButton(label: "Back", action: {
                state_subscriber(prev_state)
            })
            ButtonsGrid(items: [
                ["Translate", "Correct", "Emoji"],
                ["Expand", "Reply", "Goal"],
                ["Compress", "Paraphrase", "Format"],
                ["Scan", "Tone", "Settings"]
            ], subscriber: (String feature){
                state_subscriber(feature)
            })
        }
    }
}