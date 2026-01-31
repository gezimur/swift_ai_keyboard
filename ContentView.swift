import SwiftUI

// copy from https://github.com/0Itsuki0/SwiftCustomKeyboard/blob/main/HelloKeyboardDemo/AppSpecificKeyboardDemo.swift
//class AIKeyboardView: UIInputViewController{
//    override func viewDidLoad() {
//            super.viewDidLoad()
//                    
//            let animalKeyboardViewController = UIHostingController(
//                rootView: AIKeyboardContentView(
//                    insertText: { [weak self] text in
//                        guard let self else { return }
//                        self.textDocumentProxy.insertText(text)
//
//                    },
//                    deleteText: { [weak self] in
//                        guard let self,
//                              self.textDocumentProxy.hasText else { return }
//
//                        self.textDocumentProxy.deleteBackward()
//                    },
////                    needsInputModeSwitchKey: self.needsInputModeSwitchKey,
////    //                needsInputModeSwitchKey: true,
////                    nextKeyboardAction: #selector(self.handleInputModeList(from:with:)),
//                ))
//            
//            let animalKeyboardView = animalKeyboardViewController.view!
//            animalKeyboardView.translatesAutoresizingMaskIntoConstraints = false
//            
//            // default to white
//            animalKeyboardViewController.view.backgroundColor = .clear
//
//            
//            self.addChild(animalKeyboardViewController)
//            self.view.addSubview(animalKeyboardView)
//            animalKeyboardViewController.didMove(toParent: self)
//
//            NSLayoutConstraint.activate([
//                animalKeyboardView.leftAnchor.constraint(equalTo: view.leftAnchor),
//                animalKeyboardView.topAnchor.constraint(equalTo: view.topAnchor),
//                animalKeyboardView.rightAnchor.constraint(equalTo: view.rightAnchor),
//                animalKeyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        }
//}


fileprivate struct StateParams {
    var state: String
    var args: [String]
}

struct AIKeyboardContentView: View {
    var insert_text: (String) -> Void
    var delete_text: () -> Void
    @ObservedObject var text_manager = TextManager()
    
    @State private var current_state: StateParams = StateParams(state: "keys + suggestions", args: [])
    @State private var prev_state: [StateParams] = [StateParams(state: "keys + suggestions", args: [])]
    
//    var textDocumentProxy : any UITextDocumentProxy {get}

    var body: some View {
        GeometryReader { geometry in
            let comfort_width = geometry.size.width * 0.98
            let comfort_height = geometry.size.height * 0.9
            
            if self.current_state.state == "keys + suggestions" {
                VStack{
                    Spacer()
                    SuggestionsPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2 / 5)
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2)
                }
                
            } else if self.current_state.state == "keys + features" {
                VStack{
                    Spacer()
                    MiniFeaturesPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2 / 5)
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2)
                }
            } else if self.current_state.state == "features" {
                VStack{
                    Spacer()
                    FeaturesPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2)
                }
            } else if self.current_state.state == "keys + input tool" {
                VStack{
                    InputTool(feature_type: self.current_state.args[0],
                              feature_args: Array(self.current_state.args[1..<self.current_state.args.count]),
                              request_subscriber: self.procRequest,
                              notes: $text_manager.used_text)
                        .frame(width: comfort_width, height: geometry.size.height / 2)
                    Spacer()
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2)
                }
            } else if self.current_state.state == "translate settings" {
                VStack {
                    Spacer()
                    TranslateSettingsPanel(language_from: self.current_state.args[0],
                                           language_to: self.current_state.args[1],
                                           request_subscriber: self.procRequest)
                        .frame(width: comfort_width, height: comfort_height / 2)
                }
            }
        }
        
    }

    private func procRequest(request: String, args: [String]) {
        if request == "back" {
            if self.prev_state.count > 0 {
                self.current_state = self.prev_state[0]
                self.prev_state.removeLast()
            } else {
                self.current_state = StateParams(state: "keys + suggestions", args: [])
            }
        } else if request == "state" {
            self.prev_state.append(self.current_state)
            self.current_state = StateParams(state: args[0], args: Array(args[1..<args.count]))
        } else if request == "feature" {
            self.text_manager.askChatGpt(request: "Hello! I'm Gena")
        } else if request == "key" {
            self.insert_text(args[0])
        } else {
            print("Processing request: \(request) with args: \(args)")
        }
    }
}


#Preview {
    AIKeyboardContentView(insert_text: {_ in}, delete_text: {})
}
