import SwiftUI

@main
struct ButtonGridApp: App {
    var body: some Scene {
        
            WindowGroup {
                GeometryReader { geometry in
                    ContentView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .windowResizability(.contentSize)
    }
}
