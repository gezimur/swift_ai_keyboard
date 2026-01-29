import SwiftUI

struct LanguagesScroll: View {
    let languages: [String]
    @State var centeredItemID: String?
    var subscriber: (String) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            let element_size = geometry.size.height / 8
            let element_spacing = element_size / 7
            
            ScrollView{
                ScrollViewReader{ scroll in
                    VStack(spacing: element_spacing) {
                        Spacer().frame(height: element_size).id("Spacer 1")
                        Spacer().frame(height: element_size).id("Spacer 2")
                        Spacer().frame(height: element_size).id("Spacer 3")
                        ForEach(languages, id: \.self) { lang in
                            Text(lang)
                                .foregroundColor(.white)
                                .font(.system(size: element_size * 0.8))
                                .frame(height: element_size)
                                .id(lang)
                                .bold(lang == centeredItemID)
                                .onTapGesture {
                                    self.centeredItemID = lang
                                }
                                
                        }
                        Spacer().frame(height: element_size).id("Spacer 4")
                        Spacer().frame(height: element_size).id("Spacer 5")
                        Spacer().frame(height: element_size).id("Spacer 6")
                    }
                    .frame(maxWidth:.infinity)
                    .scrollTargetLayout()
                    .onAppear {
                        scroll.scrollTo(centeredItemID, anchor: .center)
                    }
                }
                
                
            }
            .scrollIndicators(.hidden)
            .scrollPosition(id: $centeredItemID, anchor: .center)
            .onChange(of: centeredItemID) { oldValue, newValue in
                            if let newID = newValue {
                                self.subscriber(newID)
                            }
                        }
            
            
        }
    }
    
    func scrollTo(item: String) -> LanguagesScroll{
        self.centeredItemID = item
        return self
    }
}

struct TranslateSettingsPanel: View {
    @State var language_from: String
    @State var language_to: String
    var request_subscriber: (String, [String]) -> Void
    let languages = [
        "Auto", "English",
        "Raz", "Dva", "Tri", "Cheture", "Pyat", "Shest", "Sem", "Vosem", "Devat", "Desat"
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack {
                    SquareButton(label: "", icon: "back", action: {
                        (str: String) in
                        self.request_subscriber("back", [])
                    }, style: .circle)
                    .frame(height: geometry.size.height * 0.100) // 1/8
                    
                    Spacer()
                }
                
                HStack{
                    LanguagesScroll(languages: self.languages, centeredItemID: self.language_from,
                                    subscriber: { (selected: String) in
                        self.language_from = selected
                    })
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.75) // (2/5, 6/8)
                    
                    VStack{
                        Spacer().frame(height: geometry.size.height * 0.375) // 3/8
                        Image("right-arrow")
                            .frame(width: geometry.size.width * 0.1) // (1/5, 6/8)
                        Spacer()
                        SquareButton(label: "Apply", icon: "", action: {
                            (str: String) in
                            self.request_subscriber("state", ["keys + input tool", "translate", self.language_from, self.language_to])
                        }, style: .tablet_accent)
                        .frame(height: geometry.size.height * 0.125)
                    }
                    .padding([.bottom], geometry.size.height * 0.125)
                    
                    LanguagesScroll(languages: Array(self.languages[1...(self.languages.count - 1)]), centeredItemID: self.language_to,
                                    subscriber: { (selected: String) in
                        self.language_to = selected
                    })
                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.75) // (2/5, 6/8)
                }
                .frame(height: geometry.size.height * 0.875) // 7/8
            }
        }
    }
}
