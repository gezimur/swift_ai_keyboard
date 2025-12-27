import SwiftUI

class FeatureTool: View {
    private var args: [String]
    private var request_subscriber: (String, [String]) -> Void

    var body: some View 
    
    init(args: [String], request_subscriber: (String, [String]) -> Void) {
        self.args = args[0]
        self.request_subscriber = request_subscriber

        self.body = VStack{
            HStack{
                Spacer()
                SquareButton(label: "<--", action: {
                    request_subscriber("back", [])
                })
            }
            Text("Feature Tool is not implemented yet")
        }
    }
}