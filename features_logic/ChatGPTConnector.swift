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
            let location = "/Users/gena/Downloads/gpt_key.txt"
            let optional_key = try NSString(contentsOfFile: location, encoding: NSUTF8StringEncoding) as String
            api_key = String(optional_key.prefix(optional_key.count - 1))
        } catch let error {
            print(error.localizedDescription)
            api_key = ""
        }
        print(api_key)
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

//{
//  "id": "resp_67ccd2bed1ec8190b14f964abc0542670bb6a6b452d3795b",
//  "object": "response",
//  "created_at": 1741476542,
//  "status": "completed",
//  "completed_at": 1741476543,
//  "error": null,
//  "incomplete_details": null,
//  "instructions": null,
//  "max_output_tokens": null,
//  "model": "gpt-4.1-2025-04-14",
//  "output": [
//    {
//      "type": "message",
//      "id": "msg_67ccd2bf17f0819081ff3bb2cf6508e60bb6a6b452d3795b",
//      "status": "completed",
//      "role": "assistant",
//      "content": [
//        {
//          "type": "output_text",
//          "text": "In a peaceful grove beneath a silver moon, a unicorn named Lumina discovered a hidden pool that reflected the stars. As she dipped her horn into the water, the pool began to shimmer, revealing a pathway to a magical realm of endless night skies. Filled with wonder, Lumina whispered a wish for all who dream to find their own hidden magic, and as she glanced back, her hoofprints sparkled like stardust.",
//          "annotations": []
//        }
//      ]
//    }
//  ],
//  "parallel_tool_calls": true,
//  "previous_response_id": null,
//  "reasoning": {
//    "effort": null,
//    "summary": null
//  },
//  "store": true,
//  "temperature": 1.0,
//  "text": {
//    "format": {
//      "type": "text"
//    }
//  },
//  "tool_choice": "auto",
//  "tools": [],
//  "top_p": 1.0,
//  "truncation": "disabled",
//  "usage": {
//    "input_tokens": 36,
//    "input_tokens_details": {
//      "cached_tokens": 0
//    },
//    "output_tokens": 87,
//    "output_tokens_details": {
//      "reasoning_tokens": 0
//    },
//    "total_tokens": 123
//  },
//  "user": null,
//  "metadata": {}
//}

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
