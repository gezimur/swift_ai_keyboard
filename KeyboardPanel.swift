import SwiftUI

struct KeyboardPanel: View {
    let prev_state: String
    let state_subscriber: (String) -> Void

    let central_rows_info = ["ABC": [
                ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
                ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
                ["Z", "X", "C", "V", "B", "N", "M"]
            ],
            "abc": [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ],
            "123": [
                ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                ["-", "/", ":", ";", "(", ")", "$", "&", "@", "'"],
                [".", ",", "?", "!", "\""]
            ],
            "SYM": [
                ["[", "]", "{", "}", "#", "%", "^", "*", "+", "="],
                ["_", "\\", "|", "~", "<", ">", "€", "£", "¥", "•"],
                [".", ",", "?", "!", "\""]
            ]]
    
    var current_rows = 

    var body: some View {
        VStack{
            SquareButton(label: "Back", action: {
                state_subscriber(prev_state)
            })
            ButtonsGrid(items: [
                ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
                ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
                ["Z", "X", "C", "V", "B", "N", "M"]
            ], subscriber: (String feature){
                state_subscriber(feature)
            })
        }
    }
}