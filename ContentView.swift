import SwiftUI

struct StateParams {
    var state: String
    var args: [String]
}

struct ContentView: View {
    @State private var current_state: StateParams = StateParams(state: "keys + suggestions", args: [])
    @State private var prev_state: [StateParams] = [StateParams(state: "keys + suggestions", args: [])]

    var body: some View {
        if self.current_state.state == "keys + suggestions" {
            VStack{
                SuggestionsPanel(request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state.state == "keys + features" {
            VStack{
                MiniFeaturesPanel(request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state.state == "features" {
            FeaturesPanel(request_subscriber: self.procRequest)
        } else if self.current_state.state == "keys + input tool" {
            VStack{
                InputTool(feature_type: self.current_state.args[0], request_subscriber: self.procRequest)
                KeyboardPanel(request_subscriber: self.procRequest)
            }
        } else if self.current_state.state == "feature tool" {
            FeatureTool(args: self.current_state.args, request_subscriber: self.procRequest)
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
            self.current_state = StateParams(state: args[0], args: args[1..<args.count])
        } else {
            print("Processing request: \(request) with args: \(args)")
        }
    }
}


