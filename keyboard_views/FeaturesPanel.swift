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
        GeometryReader { geometry in
            VStack{
                HStack{
                    SquareButton(label: "", icon: "back", action: {
                        (str: String) in
                        self.request_subscriber("back", [])
                    }, style: .circle)
                    .frame(height: geometry.size.height / Double(self.features.count + 1))
                    Spacer()
                }
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
}
