import SwiftUI

struct MiniFeaturesPanel: View {
    var request_subscriber: (String, [String]) -> Void
    private let features = ["Tr", "*A", "0_0", "<->"]
    private let features_info = ["Tr":"Translate", "*A":"Correct", "0_0":"Emoji", "<->":"Expand"]
    
    var body: some View {
        HStack{
            SquareButton(label: "<--", action: {
                (str : String) in
                self.request_subscriber("back", [])
            })
            HStack{
                ForEach(self.features, id: \.self){
                    feature in SquareButton(label: feature, action: {
                        (str : String) in
                        self.request_subscriber("state", ["keys + input tool", feature])
                    })
                }
            }
            SquareButton(label: "...", action: {
                (str : String) in
                self.request_subscriber("state", ["features"])
            })
        }
    }
}
