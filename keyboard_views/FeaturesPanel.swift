import SwiftUI

struct FeaturesPanel: View {
    var request_subscriber: (String, [String]) -> Void
    let features = [
        ["Translate", "Correct", "Emoji"],
        ["Expand", "Reply", "Goal"],
        ["Compress", "Paraphrase", "Format"],
        ["Scan", "Tone", "Settings"]
    ]
    
    var body: some View {
        VStack{
            SquareButton(label: "", icon: "back", action: {
                (str: String) in
                self.request_subscriber("back", [])
            }, style: .circle)
            .containerRelativeFrame(.vertical, count: features.count + 1, span: 1, spacing: 0.1)
            VStack{
                ForEach(features, id: \.self){
                    features_row in HStack{
                        ForEach(features_row, id: \.self){
                            feature in SquareButton(label: feature, icon: feature.lowercased(), action: {
                                (feature: String) in
                                self.request_subscriber("state", ["keys + input tool", feature])
                            }, style: .tablet)
                        }
                    }
                }
            }
        }
    }
}
