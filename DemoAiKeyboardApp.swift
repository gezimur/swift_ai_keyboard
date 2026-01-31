import SwiftUI

@main
struct ButtonGridApp: App {
    var body: some Scene {
            WindowGroup {
                GeometryReader { geometry in
                    AIKeyboardContentView(insert_text: {(String)in }, delete_text: {})
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
            }
            .windowResizability(.contentSize)
    }
}
