import SwiftUI

enum ButtonStyle{
    case square_gray
    case square_dark
    case square_accent
    case circle
    case tablet
    case tablet_accent
    case flat
}

struct SquareButton: View {
    let label: String
    let icon: String

    let action: (String) -> Void
    
    var style: ButtonStyle = ButtonStyle.square_gray

    var body: some View {
        GeometryReader { geometry in
            do_a_lot_of_shit(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    @ViewBuilder
    func do_a_lot_of_shit(width: Double, height :Double) -> some View{
        if self.style == ButtonStyle.square_gray {
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray, in: RoundedRectangle(cornerRadius: height * 0.1))
        }else if self.style == ButtonStyle.square_dark{
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray, in: RoundedRectangle(cornerRadius: height * 0.1))
        }else if self.style == ButtonStyle.square_accent {
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color.blue, Color.green],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        in: RoundedRectangle(cornerRadius: height * 0.1))
        }else if self.style == ButtonStyle.circle{
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray, in: Circle())
        } else if self.style == ButtonStyle.tablet{
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray, in: RoundedRectangle(cornerRadius: height * 0.5))
        } else if self.style == ButtonStyle.tablet_accent{
            Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [Color.blue, Color.green],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        in: RoundedRectangle(cornerRadius: height * 0.5))
        } else if self.style ==  ButtonStyle.flat{
             Button(action: {
                action(label)
            }) {
                HStack {
                    if icon != "" {
                        self.make_icon(width: width, height: height)
                    }
                    
                    if label != "" {
                        self.make_text(width: width, height: height)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.0), in: Rectangle())
        }
    }
    
    
//    func make_button_background() -> any ShapeStyle {
//        switch self.style {
//        case ButtonStyle.square_gray:
//        case ButtonStyle.square_dark:
//        case ButtonStyle.circle:
//        case ButtonStyle.tablet:
//            return Color.gray
//        case ButtonStyle.square_accent:
//        case ButtonStyle.tablet_accent:
//            return LinearGradient(colors: [Color.blue, Color.green],
//                                  startPoint: .topLeading,
//                                  endPoint: .bottomTrailing)
//        case ButtonStyle.flat:
//            return Color.gray.opacity(1.0)
//        }
//    }
//    
//    func make_button_shape(width: Double, height :Double) -> any InsettableShape {
//        switch self.style {
//        case ButtonStyle.square_gray:
//        case ButtonStyle.square_dark:
//        case ButtonStyle.square_accent:
//            return RoundedRectangle(cornerRadius: min(width, height) * 0.1)
//        case ButtonStyle.circle:
//            return Circle()
//        case ButtonStyle.tablet:
//        case ButtonStyle.tablet_accent:
//            return RoundedRectangle(cornerRadius: height * 0.5)
//        case ButtonStyle.flat:
//            return Rectangle()
//        }
//    }
    
    @ViewBuilder
    func make_icon(width: Double, height :Double) -> some View{
        let key_size = min(width, height)
        if self.style == ButtonStyle.square_gray ||
            self.style == ButtonStyle.square_dark ||
            self.style == ButtonStyle.square_accent ||
            self.style == ButtonStyle.circle {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: key_size * 0.7, height: key_size * 0.7)
                .background(Color.gray.opacity(0.0))
        } else if self.style == ButtonStyle.tablet{
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: key_size * 0.9, height: key_size * 0.9)
                .background(LinearGradient(colors: [Color.blue, Color.green],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            in: .circle)
        } else if self.style ==  ButtonStyle.tablet_accent ||
                    self.style ==  ButtonStyle.flat {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: key_size * 0.7, height: key_size * 0.7)
                    .background(.clear)
            }
    }
    
    @ViewBuilder
    func make_text(width: Double, height :Double) -> some View{
        let key_size = min(width, height)
            
        Text(self.label)
            .foregroundColor(.white)
            .font(.system(size: key_size * 0.6))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.clear)
    }
}
