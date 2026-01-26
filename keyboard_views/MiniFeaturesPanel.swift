import SwiftUI

struct MiniFeaturesPanel: View {
    var request_subscriber: (String, [String]) -> Void
    private let features_info = ["translate", "correct", "emoji", "expand"]
    
    var body: some View {
        HStack{
            SquareButton(label: "", icon: "back", action: {
                (str : String) in
                self.request_subscriber("back", [])
            }, style: .circle)
            HStack{
                ForEach(self.features_info, id: \.self){
                    feature in SquareButton(label: "", icon: feature, action: {
                        (str : String) in
                        self.request_subscriber("state", ["keys + input tool", feature])
                    }, style: .flat)
                }
            }
            SquareButton(label: "", icon: "more", action: {
                (str : String) in
                self.request_subscriber("state", ["features"])
            }, style: .circle)
        }
    }
}
