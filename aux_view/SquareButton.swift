import SwiftUI

struct SquareButton: View {
    let label: String
    let icon: String

    let action: (String) -> Void
    
    let round_flag: Bool = false
    let gradient_flag: Bool = false
    let icon_gradient_flag: Bool = false

    var body: some View {
        let button_view = Button(action: {
            action(label)
        }) {
            if label != "" {
                Text(label)
                .font(.system(size: font_size, weight: .semibold))
                .foregroundColor(.white)
            }
            if icon != "" {
                let icon_view = Image(icon)
                if icon_gradient_flag {
                    icon_view.background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                } else {
                    icon_view.background(Color.gray)
                }
            }
        }

        if round_flag {
            button_view.buttonStyle(.borderedProminent)
        }

        if gradient_flag {
            button_view.background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green, Color.blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        } else {
            button_view.background(Color.gray)
        }
    }
}
