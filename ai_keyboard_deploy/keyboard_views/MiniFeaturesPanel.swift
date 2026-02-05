import SwiftUI

struct MiniFeaturesPanel: View {
    var request_subscriber: (String, [String]) -> Void
    private let features_info = ["translate", "correct", "emoji", "expand"]
    
    var body: some View {
        GeometryReader {geometry in
            let buttons_count = Double(features_info.count + 2)
            let button_width = 0.95 * geometry.size.width / buttons_count
            HStack{
                SquareButton(label: "", icon: "back", action: {
                    (str : String) in
                    self.request_subscriber("back", [])
                }, style: .circle)
                .frame(width: button_width)
                HStack{
                    ForEach(self.features_info, id: \.self){
                        feature in SquareButton(label: "", icon: feature, action: {
                            (str : String) in
                            self.request_subscriber("state", ["keys + input tool", feature])
                        }, style: .flat)
                        .frame(width: button_width)
                    }
                }
                SquareButton(label: "", icon: "more", action: {
                    (str : String) in
                    self.request_subscriber("state", ["features"])
                }, style: .circle)
                .frame(width: button_width)
            }
        }
    }
}
