import SwiftUI

struct InputTool: View {
    var feature_type: String
    var request_subscriber: (String, [String]) -> Void
    @State private var notes: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            let button_size = 0.95 * geometry.size.height / 9
            
            VStack{
                HStack{
                    SquareButton(label: "", icon: "back", action: {
                        (str: String) in
                        self.request_subscriber("back", [])
                    }, style: .circle)
                    .frame(width: button_size)
                    if feature_type == "translate" {
                        Text("Super feature")
                    } else {
                        Text(feature_type.capitalized)
                    }
                    Spacer()
                }
                .frame(height: button_size)
                TextEditor(text: $notes)
                    .frame(width: geometry.size.width * 0.96)
                    .font(.system(size: geometry.size.height * 0.05))
                    .cornerRadius(geometry.size.height * 0.05)
                HStack{
                    SquareButton(label: "", icon: "refresh", action: {(str: String) in }, style: .circle)
                        .frame(width: button_size)
                    SquareButton(label: "", icon: "undo", action: {(str: String) in }, style: .circle)
                        .frame(width: button_size)
                    SquareButton(label: "", icon: "redo", action: {(str: String) in }, style: .circle)
                        .frame(width: button_size)
                    Spacer()
                    SquareButton(label: "apply", icon: "", action: {(str: String) in }, style: .tablet_accent)
                        .frame(width: button_size * 2.5)
                }
                .frame(height: button_size)
            }
        }
    }
}
