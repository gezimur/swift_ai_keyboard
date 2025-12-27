import SwiftUI

struct ContentView: View {
    @State private var current_state: String = "keys + suggestions"

    @State private var prev_state: [String] = ["keys + suggestions"]
    @State private var current_args: [String] = [""]

    var body: some View {
        if self.current_state == "keys + suggestions" {
            VStack{
                SuggestionsPanel(request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state == "keys + features" {
            VStack{
                MiniFeaturesPanel(request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state == "features" {
            FeaturesPanel(request_subscriber: self.procRequest)
        } else if self.current_state == "keys + input tool" {
            VStack{
                InputTool(feature_type: self.current_args[0], request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state == "feature tool" {
            FeatureTool(args: self.current_args, request_subscriber: self.procRequest)
        }
    }

    private func procRequest(request: String, args: [String]) {
        if request == "back" {
            self.current_state = self.prev_state[0]
//            self.current_args = self.prev_state[1 : self.prev_state.count - 1]
        } else if request == "state" {
            self.prev_state = [self.current_state]
            self.prev_state += self.current_args

            self.current_state = args[0]
//            self.current_args = args[1..<args.count]
        } else {
            print("Processing request: \(request) with args: \(args)")
        }
    }
}


