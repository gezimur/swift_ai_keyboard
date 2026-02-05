import Foundation

struct ChatGPTResponce: Decodable {
  let text: String
}

class ChatGPTConnector {
    private let api_key : String
    private let api_url = "https://api.openai.com/v1/chat/completions"
    
    var subscriber: (String) -> Void = {String in}

    init(){
        do {
//            let location = "/Users/gena/Downloads/gpt_key.txt"
//            let optional_key = try NSString(contentsOfFile: location, encoding: NSUTF8StringEncoding) as String
//            api_key = String(optional_key.prefix(optional_key.count - 1))
            api_key = ""
        } catch let error {
            print(error.localizedDescription)
            api_key = ""
        }
    }
    
    func subscribeOnAnswer(subscriber: @escaping (String) -> Void) {
        self.subscriber = subscriber
    }
    
    func askChat(message: String) -> Void {
        guard let url = URL(string: api_url) else { return }

        let messages = [
            ["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": message]
        ]

        let json: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": messages,
            "response_format": [
                                    "type": "text"
                                ]
        ]

        guard let json_data = try? JSONSerialization.data(withJSONObject: json) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(api_key)", forHTTPHeaderField: "Authorization")
        request.httpBody = json_data

        Task {
            do {
                let (response_data, _) = try await URLSession.shared.data(for: request)
                
                let decoder = JSONDecoder()
                let openAIResponse = try decoder.decode(OpenAIResponse.self, from: response_data)
                
                if (openAIResponse.error == nil) {
                    if (openAIResponse.output != nil){
                        let response_output = openAIResponse.output!
                        self.subscriber(response_output.first!.content.first!.text)
                    }
                } else {
                    self.subscriber(openAIResponse.error!.message)
                }
                
            } catch let error {
                print("Error occured: ", error.localizedDescription)
            }
        }
    }
}

// MARK: - Response Models
struct OpenAIResponse: Codable {
    let error: ErrorContent?
    let output: [ChatResponce]?
}

struct ChatResponce: Codable {
    let content: [ChatContent]
}

struct ChatContent: Codable {
    let type: String
    let text: String
    let annotations: [String]
}

struct ErrorContent: Codable {
    let type: String
    let message: String
    let code: String
}
