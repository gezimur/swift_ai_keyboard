import SwiftUI

class MiniFeaturesPanel: View {
    private var request_subscriber: (String, [String]) -> Void
    private var features: [String] = ["Tr":"Translate", "*A":"Correct", "0_0":"Emoji", "<->":"Expand"]
    var body: some View 
    
    init(request_subscriber: (String, [String]) -> Void) {
        self.request_subscriber = request_subscriber

        self.body = VStack{
            SquareButton(label: "<--", action: {
                request_subscriber("back", [])
            })
            HStack{
                ForEach(features, id: \.self){
                    features in SquareButton(label: features, action: {
                        request_subscriber("state", [features])
                    })
                }
            }
            SquareButton(label: "...", action: {
                request_subscriber("state", ["features"])
            })
        }
    }
}