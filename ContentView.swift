import SwiftUI

class ContentView: View {
    @State private var current_state: String = "keys + suggestions"

    private var prev_state: [String] = ["keys + suggestions"]
    private var current_args: [String] = []

    var body: some View {
        if current_state == "keys + suggestions" {
            VStack{
                SuggestionsPanel(args: current_args, request_subscriber: procRequest)
                KeyboardPanel(request_subscriber: procRequest)
            }
        } else if current_state == "keys + features" {
            VStack{
                MiniFeaturesPanel(request_subscriber: procRequest)
                KeyboardPanel(request_subscriber: procRequest)
            }
        } else if current_state == "features" {
            FeaturesPanel(request_subscriber: procRequest)
        } else if current_state == "keys + input tool" {
            VStack{
                InputTool(args: current_args, request_subscriber: procRequest)
                KeyboardPanel(request_subscriber: procRequest)
            }
        } else if current_state == "feature tool" {
            FeatureTool(args: current_args, request_subscriber: procRequest)
        } else {
            print("Invalid state: \(current_state)")
        }
    }

    private func procRequest(request: String, args: [String]) {
        if request == "back" {
            current_state = prev_state[0]
            current_args = prev_state[1..<prev_state.count]
        } else if request == "state" {
            prev_state = current_state
            prev_state.append(current_args)

            current_state = args[0]
            current_args = args[1..<args.count]
        } else {
            print("Processing request: \(request) with args: \(args)")
        }
    }
}


