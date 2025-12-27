import SwiftUI

struct FeatureTool: View {
    var args: [String]
    var request_subscriber: (String, [String]) -> Void
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                SquareButton(label: "<--", action: {
                    (str : String) in
                    request_subscriber("back", [])
                })
            }
            Text("Feature Tool is not implemented yet")
        }
    }
}
