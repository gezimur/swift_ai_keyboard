import SwiftUI

struct StateParams {
    var state: String
    var args: [String]
}

struct ContentView: View {
    @State private var current_state: StateParams = StateParams(state: "keys + suggestions", args: [])
    @State private var prev_state: [StateParams] = [StateParams(state: "keys + suggestions", args: [])]

    var body: some View {
        GeometryReader { proxy in
            if self.current_state.state == "keys + suggestions" {
                VStack{
                    SuggestionsPanel(request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 5, span: 1, spacing: 0.1)
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 5, span: 4, spacing: 0.1)
                }
//                .frame(width: proxy.size.width, height: proxy.size.height)
                
            } else if self.current_state.state == "keys + features" {
                VStack{
                    MiniFeaturesPanel(request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 5, span: 1, spacing: 0.1)
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 5, span: 4, spacing: 0.1)
                }
//                .frame(width: proxy.size.width, height: proxy.size.height)
            } else if self.current_state.state == "features" {
                FeaturesPanel(request_subscriber: self.procRequest)
//                    .frame(width: proxy.size.width, height: proxy.size.height)
            } else if self.current_state.state == "keys + input tool" {
                VStack{
                    InputTool(feature_type: self.current_state.args[0], request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 2, span: 1, spacing: 0.1)
                    KeyboardPanel(request_subscriber: self.procRequest)
                        .containerRelativeFrame(.vertical, count: 2, span: 1, spacing: 0.1)
                }
//                .frame(width: proxy.size.width, height: proxy.size.height)
            } else if self.current_state.state == "feature tool" {
                FeatureTool(args: self.current_state.args, request_subscriber: self.procRequest)
//                    .frame(width: proxy.size.width, height: proxy.size.height)
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
//            let myurl = URL(string: "")!
//            var url_request = URLRequest(url: myurl)
//            NSURLSession.dataTaskWithRequest()
//            }
        } else {
            print("Processing request: \(request) with args: \(args)")
        }
    }
}


