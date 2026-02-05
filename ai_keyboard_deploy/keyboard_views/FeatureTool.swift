import SwiftUI

struct FeatureTool: View {
    var args: [String]
    var request_subscriber: (String, [String]) -> Void
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                SquareButton(label: "", icon: "back", action: {
                    (str : String) in
                    request_subscriber("back", [])
                }, style: .circle)
            }
            Text("Feature Tool is not implemented yet")
        }
    }
}
