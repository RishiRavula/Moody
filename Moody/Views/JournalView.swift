//
//  JournalView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/14.
//

import SwiftUI

let sadPrompts = ["Where do you want to be most right now?","How could today have gone differently?","What frustrated you today?"]

let happyPrompts = ["What was the best part of today?","What was your last smile about?","I'm most grateful for..."]


let prompts = ["How was your day today","Describe yourself to a stranger ","Reflect on these last couple days","describe what's on your mind","Where do you want to be right now","What Are You Thinking About","How Could Today Have Gone Differently",]

func randomizePrompt(prompt: [String]) -> String {
    
    return prompt[Int.random(in: 0...prompt.count-1)]
    
}



struct JournalView: View {
    
    @State var emojiSlider: Double = 0
    @State var showSidebar: Bool = false
    @State var userEmotionInput: String = ""
    @State var showSave: Bool = false
    @State var dateInput = Date()
    @State var pressedFlag: Bool = false
    @EnvironmentObject var modelData: ModelData //OVERALL GLOBAL STORING MECHANISM
    //@State var prompts = ["How Was Your Day Today","Describe Yourself to a Stranger ","Reflect on These Last Couple Days","Describe What's on Your Mind","What Do You Need the Most Right Now","What Are You Thinking About","How Could Today Have Gone Differently","How Are You Feeling Today"]
    @State var promptQuestion: String = randomizePrompt(prompt: prompts)
    @State var happyPrompt: String = randomizePrompt(prompt: happyPrompts)
    @State var sadPrompt: String = randomizePrompt(prompt: sadPrompts)
    @State private var totalChars = 0
    
    //In order for user to not select date beyond today
    var todayDateRange: ClosedRange<Date>{
        let min = Date(timeIntervalSince1970: 0)
        let max = Date.now
        return min...max
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
                            Text("How are you feeling today?")
                                .foregroundColor(.black)
                                .font(.title).bold()
                                .padding()
                            Slider(value: $emojiSlider,
                                   in: -10...10).tint(Color(.sRGB, red: 1.0, green: 0.1 + 0.7*(emojiSlider+10)/20, blue: 0.0, opacity: 1.0)).padding([.bottom, .trailing,.leading])
                            
                        }.background(
                            Image("celestial").resizable().cornerRadius(15)
                        )
                            .padding()
                        
                        
                        VStack {
                            
                            if emojiSlider > 4 {
                                Text("\(happyPrompt)")
                                    .foregroundColor(.black)
                                    .font(.title).bold()
                                    .padding([.top, .trailing,.leading])
                            } else if emojiSlider < -4 {
                                Text("\(sadPrompt)")
                                    .foregroundColor(.black)
                                    .font(.title).bold()
                                    .padding([.top, .trailing,.leading])
                            } else {
                                Text("\(promptQuestion)")
                                    .foregroundColor(.black)
                                    .font(.title).bold()
                                    .padding([.top, .trailing,.leading])
                            }
                            
                            
                            TextEditor(text: $userEmotionInput)
                                .foregroundColor(.black)
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
                                //BURNER API CALL TO INITALIZE IT, INEFFICIENT BUT WILL FIX LATER
                                
                                let testEntry = JournalEntries()
                                testEntry.journal = "Test This Entry For Sadness"
                                testEntry.emotionalLvl = APICall(entry: testEntry)
                                
                                
                                
                                //ADD LOGIC TO ONLY SAVE UPON CLICKING THE BUTTON ONCE, RIGHT NOW IT DOUBLE SAVES WHICH NEEDS WORK
                                
                                // SAVE JOUNRAL ENTRY AND ADD TO OVERALL ARRAY
                                let currEntry = JournalEntries()
                                currEntry.date = dateInput
                                currEntry.journal = userEmotionInput
                                currEntry.sliderVal = emojiSlider
                                
                                if emojiSlider > 4 {
                                    currEntry.question = happyPrompt
                                } else if emojiSlider < -4 {
                                    currEntry.question = sadPrompt
                                } else {
                                    currEntry.question = promptQuestion
                                }
                                currEntry.emotionalLvl = APICall(entry: currEntry)
                                currEntry.uniqueID = UUID().uuidString
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    print(modelData.pastEntries.count)
                                    print("CURR ENTRY IS: \n \( currEntry.date) \n \(currEntry.journal) \n \(currEntry.sliderVal) \n \(currEntry.question) \n \(currEntry.emotionalLvl)\n \(currEntry.uniqueID)")
                                    self.modelData.pastEntries.append(currEntry)
                                    self.modelData.save(entries: modelData.pastEntries)
                                    
                                }
//                                sliderVals = getSliderValuesArray(data: self.modelData.pastEntries)
//                                emotionVals = getEmotionLevelValuesArray(data: self.modelData.pastEntries)
                            } label: {
                                Text("Save")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(pressedFlag ? .cgDarkGray : .black)
                            }
                            .onTapGesture {
                                pressedFlag.toggle()
                            }
                            .background(
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
            
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showSidebar.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3").scaleEffect(1.5)
                        .foregroundColor(Color(.gray))
                    
                }
            ), trailing: (
                DatePicker("", selection: $dateInput,
                           in: todayDateRange,
                           displayedComponents: .date
                          ).background(.white.opacity(0.3))
                    .cornerRadius(5)
                    .padding()
            ))
        }
//        .preferredColorScheme(.light)
        .navigationBarHidden(true)
        
    }
}

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView().environmentObject(ModelData())
    }
}



