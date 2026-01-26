import SwiftUI

struct KeyboardPanel: View {
    @State private var current_mode: String = "abc"
    var request_subscriber: (String, [String]) -> Void

    let mode_switch_button_info = ["ABC": "123", "abc": "123", "123": "abc", "SYM": "abc"]
    let shift_button_info = ["ABC": "shift", "abc": "SHIFT", "123": "1/2", "SYM": "2/2"]
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

    var body: some View {
        VStack{
            ButtonsRow(items: self.central_rows_info[self.current_mode]![0], subscriber: self.procKey)
            ButtonsRow(items: self.central_rows_info[self.current_mode]![1], subscriber: self.procKey)
            
            HStack {
                let items_count = self.central_rows_info[self.current_mode]![2].count + 3
                
                SquareButton(label: self.shift_button_info[self.current_mode]!, icon:"", action: self.procShift)
                    .containerRelativeFrame(.horizontal, count: items_count, span: 1, spacing: 0.1)
                ButtonsRow(items: self.central_rows_info[self.current_mode]![2], subscriber: self.procKey)
                    .containerRelativeFrame(.horizontal, count: items_count, span: items_count - 3, spacing: 0.1)
                SquareButton(label: "Backspace", icon:"", action: self.procBackspace)
                    .containerRelativeFrame(.horizontal, count: items_count, span: 1, spacing: 0.1)
            }
            
            HStack {
                SquareButton(label: self.mode_switch_button_info[self.current_mode]!, icon:"", action: {
                    (str : String) in
                    self.procModeSwitch(key: str)
                })
                    .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0.1)
                SquareButton(label: "", icon:"lang", action: {(str: String) in })
                    .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0.1)
                SquareButton(label: "", icon:"", action: self.procKey)
                    .containerRelativeFrame(.horizontal, count: 10, span: 6, spacing: 0.1)
                SquareButton(label: "Enter", icon:"", action: self.procEnter, style: .square_accent)
                    .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0.1)
            }
        }
    }
    
    func procKey(key: String) {
        self.request_subscriber("key", [key])
    }

    private func procShift(key: String) {
        if self.current_mode == "ABC" {
            self.current_mode = "abc"
        } else if self.current_mode == "abc" {
            self.current_mode = "ABC"
        } else if self.current_mode == "123" {
            self.current_mode = "SYM"
        } else if self.current_mode == "SYM" {
            self.current_mode = "123"
        }
    }

    private func procModeSwitch(key: String) {
        self.current_mode = self.mode_switch_button_info[self.current_mode]!
    }

    private func procBackspace(key: String) {
        self.request_subscriber("backspace", [""])
    }

    private func procEnter(key: String) {
        self.request_subscriber("enter", [""])
    }
}
