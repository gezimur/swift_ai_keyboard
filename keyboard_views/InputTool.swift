import SwiftUI

struct InputTool: View {
    var feature_type: String
    var request_subscriber: (String, [String]) -> Void
    @State private var notes: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                HStack{
                    SquareButton(label: "", icon: "back", action: {
                        (str: String) in
                        self.request_subscriber("back", [])
                    }, style: .circle)
                    .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 0.1)
                    Spacer()
                    // if feature_type == ... then show special tools
                }
                TextEditor(text: $notes)
                    .frame(width: geometry.size.width * 0.96, height: geometry.size.height * 0.5)
                    .font(.system(size: geometry.size.height * 0.05))
                    .cornerRadius(geometry.size.height * 0.05)
                HStack{
                    SquareButton(label: "", icon: "refresh", action: {(str: String) in }, style: .circle)
                        .containerRelativeFrame(.horizontal, count: 12, span: 1, spacing: 0.1)
                    SquareButton(label: "", icon: "undo", action: {(str: String) in }, style: .circle)
                        .containerRelativeFrame(.horizontal, count: 12, span: 1, spacing: 0.1)
                    SquareButton(label: "", icon: "redo", action: {(str: String) in }, style: .circle)
                        .containerRelativeFrame(.horizontal, count: 12, span: 1, spacing: 0.1)
                    Spacer()
                        .containerRelativeFrame(.horizontal, count: 13, span: 6, spacing: 0.1)
                    SquareButton(label: "apply", icon: "", action: {(str: String) in }, style: .tablet_accent)
                        .containerRelativeFrame(.horizontal, count: 12, span: 1, spacing: 0.1)
                }
            }
        }
    }
}
