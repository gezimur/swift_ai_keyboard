import SwiftUI

struct TranslateSettingsPanel: View {
    var request_subscriber: (String, [String]) -> Void
    let languages = [
        "Raz", "Dva", "Tri", "Mnogo",
        "Raz", "Dva", "Tri", "Mnogo",
        "Raz", "Dva", "Tri", "Mnogo",
        "Raz", "Dva", "Tri", "Mnogo",
        "Raz", "Dva", "Tri", "Mnogo"
    ]
    
    var body: some View {
        VStack{
            SquareButton(label: "", icon: "back", action: {
                (str: String) in
                self.request_subscriber("back", [])
            }, style: .circle)
            HStack{
                ScrollView { // Vertical by default
                    VStack(spacing: 20) {
                        ForEach(languages, id: \.self) { lang in
                            Text(lang)
                        }
                    }
                    .padding()
                }
                Text("<-->")
                ScrollView { // Vertical by default
                    VStack(spacing: 20) {
                        ForEach(languages, id: \.self) { lang in
                            Text(lang)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
