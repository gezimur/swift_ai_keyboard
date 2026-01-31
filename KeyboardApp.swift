import SwiftUI

import SwiftUI

@main
struct ButtonGridApp: App {
    var body: some Scene {
        
            WindowGroup {
                GeometryReader { geometry in
                    AIKeyboardContentView(insertText: {(String)in }, deleteText: {})
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
            }
            .windowResizability(.contentSize)
    }
}
