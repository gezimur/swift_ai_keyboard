import SwiftUI

struct ButtonsGrid: View {
    let items: [[String]]
    
    var body: some View {
        VStack{
            ForEach(items, id: \.self){
                item in ButtonsRow(items: item)
            }
        }
    }
}

struct ButtonsRow: View {
    let items: [String]

    var body: some View {
        HStack{
            ForEach(items, id: \.self){
                item in SquareButton(label: item, action: {
                    print(item)
                })
            }
        }
    }
}
