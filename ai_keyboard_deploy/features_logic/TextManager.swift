import Combine

class TextManager: ObservableObject {
    @Published public var used_text = ""
    
    var undo_cache: [String] = []
    var redo_cache: [String] = []
    
    var chat_gpt_connector = ChatGPTConnector()
    
    init(){
        undo_cache = []
        redo_cache = []
        
        chat_gpt_connector.subscribeOnAnswer(subscriber: {
            (answer: String) in
            self.cacheText(text: answer)
            self.used_text = answer
        })
    }
    
    func askChatGpt(request: String) {
        chat_gpt_connector.askChat(message: request)
    }
    
    func cacheText(text: String){
        undo_cache.append(text)
        redo_cache.removeAll()
    }
    
    func undo(){
        redo_cache.append(used_text)
        used_text = undo_cache.popLast() ?? ""
    }
    
    func redo(){
        undo_cache.append(used_text)
        
        if redo_cache.count > 0 {
            used_text = redo_cache.popLast()!
        }
    }
}
