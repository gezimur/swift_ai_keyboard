import SquareButton

struct ButtonsGrid: View {
    let items = [[String]]
    
    var body: some View {
        VStack{
            forEach(items, id: \.self){
                item in ButtonsRow(items: item)
            }
        }
    }
}

struct ButtonsRow: View {
    let items = [String]

    var body: some View {
        HStack{
            forEach(items, id: \.self){
                item in SquareButton(label: item, action: {
                    print(item)
                })
            }
        }
    }
}