//
//  EditEntryView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/4/5.
//

import SwiftUI

struct EditEntryView: View {
    
    var entry: JournalEntries

    @State var emojiSlider: Double = 0
    @State var showSidebar: Bool = false
    @State var userEmotionInput: String = ""
    @State var dateInput = Date()
    @EnvironmentObject var modelData: ModelData
    @State var promptQuestion: String = randomizePrompt(prompt: prompts)
    @State private var totalChars = 0
    @State var uniqueID2: String = ""

    init(entry: JournalEntries){
            self.entry = entry
            self._emojiSlider = State(initialValue: entry.sliderVal)
            self._userEmotionInput = State(initialValue: entry.journal)
            self._uniqueID2 = State(initialValue: entry.uniqueID)
            self._dateInput = State(initialValue: entry.date)
            self._totalChars = State(initialValue: entry.journal.count)
            self._promptQuestion = State(initialValue: entry.question)
        }

    var body: some View {
        
        
        NavigationView {
            SideBarStack(sidebarWidth: 125, showSidebar: $showSidebar) {
                // Sidebar content here
                SidebarContent().environmentObject(modelData)
            } content: {
                // Main content here
                HStack {
                    Spacer()
                    VStack{
                        VStack{
                            Text("How are you feeling today?").font(.title).bold()
                                .padding()
                            Slider(value: $emojiSlider,
                                   in: -10...10).tint(Color(.sRGB, red: 1.0, green: 0.1 + 0.7*(emojiSlider+10)/20, blue: 0.0, opacity: 1.0)).padding([.bottom, .trailing,.leading])
                            
                        }.background(
                            Image("celestial").resizable().cornerRadius(15)
                        )
                        .padding()
                        
                        
                        VStack {
                                Text("\(promptQuestion)")
                                    .font(.title).bold()
                                    .padding([.top, .trailing,.leading])
                            
                            

                            TextEditor(text: $userEmotionInput)
                                .frame(height: 45 + 45*CGFloat((totalChars/35)))
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                                .background(.white.opacity(0.3))
                                .cornerRadius(15)
                                .padding()
                                .disableAutocorrection(true)
                                .onAppear() {
                                    UITextView.appearance().backgroundColor = UIColor.clear
                                }
                                .onChange(of: userEmotionInput, perform: { text in
                                    totalChars = text.count
                                })

                            
                        }.background(
                            Image("redg").resizable().cornerRadius(15)
                        )
                        .padding()
                        
                        
                        
                        HStack {
                            Button {
                                for target in modelData.pastEntries {
                                    if(target.uniqueID == uniqueID2){
                                        print("found")
                                        
                                        let testEntry = JournalEntries()
                                        testEntry.journal = "Test This Entry For Sadness"
                                        testEntry.emotionalLvl = APICall(entry: testEntry)
                                        
                                        
                                        target.journal = userEmotionInput
                                        target.emotionalLvl = APICall(entry: target)
                                        target.date = dateInput
                                        target.sliderVal = emojiSlider
                                        
                                        
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            print(modelData.pastEntries.count)
                                            print(target.emotionalLvl)
                                            
                                            //self.modelData.pastEntries.append(target)
                                            self.modelData.save(entries: modelData.pastEntries)
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        
                                                self.modelData.load()
                                                print("reload")
                                        }


                                        break;
                                    }

                                }
                                
                            
                                

                            } label: {
                                Text("Save")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                            }.background(
                                Image("redg").resizable().cornerRadius(15).frame(width: 100, height: 40)
                            )
                            Spacer()
                        }.offset(x:42)
                        
                    }.offset(y:-60)

                }
            }
            .edgesIgnoringSafeArea(.all).background(
                Image("darkbackground").resizable().ignoresSafeArea()
            )
        }.navigationBarHidden(false)
        
    }
}

struct EditEntryView_Previews: PreviewProvider {
    static var previews: some View {
        EditEntryView(entry: ModelData().pastEntries[3]).environmentObject(ModelData())
    }
}
