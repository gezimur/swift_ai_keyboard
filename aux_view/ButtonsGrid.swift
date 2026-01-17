import SwiftUI

struct ButtonsGrid: View {
    let items: [[String]]
    let subscriber: (String) -> Void

    var body: some View {
        VStack{
            ForEach(items, id: \.self){
                item in ButtonsRow(items: item, subscriber: subscriber)
                .containerRelativeFrame(.vertical, count: items.count)
            }
        }
    }
}

struct ButtonsRow: View {
    let items: [String]
    let subscriber: (String) -> Void

    var body: some View {
        HStack{
            ForEach(items, id: \.self){
                item in SquareButton(label: item, action: subscriber)
                .containerRelativeFrame(.horizontal, count: items.count)
            }
        }
    }
}
