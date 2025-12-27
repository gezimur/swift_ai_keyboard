import SwiftUI

class InputTool: View {
    private var feature_type: String
    private var request_subscriber: (String, [String]) -> Void
    @state private var notes: String = ""

    var body: some View 
    
    init(args: [String], request_subscriber: (String, [String]) -> Void) {
        self.feature_type = args[0]
        self.request_subscriber = request_subscriber

        self.body = VStack{
            HStack{
                SquareButton(label: "<--", action: {
                    request_subscriber("back", [])
                })
                Spacer()
                // if feature_type == ... then show special tools
            }
            TextEditor(text: $notes).frame(height: 200)
            HStack{
                SquareButton(label: "reset", action: {})
                SquareButton(label: "undo", action: {})
                SquareButton(label: "redo", action: {})
                Spacer()
                SquareButton(label: "apply", action: {})
            }
        }
    }
}