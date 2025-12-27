import SwiftUI

class KeyboardPanel: View {
    @state private var current_mode: String = "abc"
    private var request_subscriber: (String, [String]) -> Void

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

    var body: some View

    init(request_subscriber: (String, [String]) -> Void) {
        self.request_subscriber = request_subscriber

        self.body = {
            VStack{

                ButtonsRow(items: central_rows_info[current_mode][0], subscriber: procKey)
                ButtonsRow(items: central_rows_info[current_mode][1], subscriber: procKey)

                HStack {
                    SquareButton(label: shift_button_info[current_mode], action: procShift)
                    ButtonsRow(items: central_rows_info[current_mode][2], subscriber: procKey)
                    SquareButton(label: "Backspace", action: procBackspace)
                }

                HStack {
                    SquareButton(label: mode_switch_button_info[current_mode], action: procModeSwitch)
                    SquareButton(label: "Lang", action: {})
                    SquareButton(label: "Space", action: procKey)
                    SquareButton(label: "Enter", action: procEnter)
                }
            }
        }
    }

    private func procKey(key: String) {
        request_subscriber("key", [key])
    }

    private func procShift(key: String) {
        if current_mode == "ABC" {
            current_mode = "abc"
        } else if current_mode == "abc" {
            current_mode = "ABC"
        } else if current_mode == "123" {
            current_mode = "SYM"
        } else if current_mode == "SYM" {
            current_mode = "123"
        }
    }

    private func procModeSwitch(key: String) {
        current_mode = mode_switch_button_info[current_mode]
    }

    private func procBackspace(key: String) {
        request_subscriber("backspace", [""])
    }

    private func procEnter(key: String) {
        request_subscriber("enter", [""])
    }
}