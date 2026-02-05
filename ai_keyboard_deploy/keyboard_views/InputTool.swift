import SwiftUI

struct TranslateSettingsButton: View{
    @State var language_from = "Auto"
    @State var language_to = "English"
    var request_subscriber: (String, [String]) -> Void
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                SquareButton(label: language_from, icon: "", action: {
                    (str: String) in
                    request_subscriber("state", ["translate settings", language_from, language_to])
                }, style: .tablet)
                .frame(width: geometry.size.width * 0.4)
                
                SquareButton(label: "", icon: "swap", action: {
                    (str: String) in
                    swap(&self.language_from, &self.language_to)
                }, style: .circle)
                .frame(width: geometry.size.width * 0.2)
                
                SquareButton(label: language_to, icon: "", action: {
                    (str: String) in
                    request_subscriber("state", ["translate settings", language_from, language_to])
                }, style: .tablet)
                .frame(width: geometry.size.width * 0.4)
            }
        }
    }
}

struct InputTool: View {
    var feature_type: String
    var feature_args: [String]
    var request_subscriber: (String, [String]) -> Void

    public var notes: Binding<String>
    
    var body: some View {
        GeometryReader{ geometry in
            let button_size = 0.95 * geometry.size.height / 7
            
            VStack{
                HStack{
                    SquareButton(label: "", icon: "back", action: {
                        (str: String) in
                        self.request_subscriber("back", [])
                    }, style: .circle)
                    .frame(width: button_size)
                    if self.feature_type == "translate" {
                        if self.feature_args.count < 2 {
                            TranslateSettingsButton(request_subscriber: self.request_subscriber)
                        } else {
                            TranslateSettingsButton(language_from: feature_args[0],
                                                    language_to: feature_args[1],
                                                    request_subscriber: self.request_subscriber)
                        }
                    } else {
                        Text(self.feature_type.capitalized)
                    }
                    Spacer()
                }
                .frame(height: button_size)
                TextEditor(text: notes)
                    .frame(width: geometry.size.width * 0.96)
                    .font(.system(size: geometry.size.height * 0.05))
                    .cornerRadius(geometry.size.height * 0.05)
                HStack{
                    SquareButton(label: "", icon: "refresh", action: {
                        (str: String) in
                        self.request_subscriber("feature", [self.feature_type, notes.wrappedValue])
                    }, style: .circle)
                        .frame(width: button_size)
                    SquareButton(label: "", icon: "undo", action: {
                        (str: String) in
                        self.request_subscriber("undo", [notes.wrappedValue])
                    }, style: .circle)
                        .frame(width: button_size)
                    SquareButton(label: "", icon: "redo", action: {
                        (str: String) in
                        self.request_subscriber("redo", [notes.wrappedValue])
                    }, style: .circle)
                        .frame(width: button_size)
                    Spacer()
                    SquareButton(label: "apply", icon: "", action: {
                        (str: String) in
                        self.request_subscriber("feature", [self.feature_type, notes.wrappedValue])
                    }, style: .tablet_accent)
                        .frame(width: button_size * 2.5)
                }
                .frame(height: button_size)
            }
        }
    }
}
