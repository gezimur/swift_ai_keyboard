import SwiftUI

struct InputTool: View {
    var feature_type: String
    var request_subscriber: (String, [String]) -> Void
    @State private var notes: String = ""
    
    var body: some View {
        VStack{
            HStack{
                SquareButton(label: "<--", action: {
                    (str: String) in
                    self.request_subscriber("back", [])
                })
                Spacer()
                // if feature_type == ... then show special tools
            }
            TextEditor(text: $notes).frame(height: 200)
            HStack{
                SquareButton(label: "reset", action: {(str: String) in })
                SquareButton(label: "undo", action: {(str: String) in })
                SquareButton(label: "redo", action: {(str: String) in })
                Spacer()
                SquareButton(label: "apply", action: {(str: String) in })
            }
        }
    }
}
