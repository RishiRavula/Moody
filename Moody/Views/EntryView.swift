//
//  EntryView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/4/5.
//

import SwiftUI

struct EntryView: View {
    var entry: JournalEntries

    @State var emojiSlider: Double = 0
    @State var moodSlider: Double = 0

    @State var showSidebar: Bool = false
    @State var userEmotionInput: String = ""
    @State var dateInput = Date()
    @EnvironmentObject var modelData: ModelData
    @State var promptQuestion: String = randomizePrompt(prompt: prompts)
    @State var moodColorValue: Double = 0
    @State private var totalChars = 0
    @State var userEmotionInput2: String = ""

    init(entry: JournalEntries){
            self.entry = entry
            self._moodSlider = State(initialValue: entry.emotionalLvl)

            self._emojiSlider = State(initialValue: entry.sliderVal)
            self._userEmotionInput = State(initialValue: entry.journal)
            self._userEmotionInput2 = State(initialValue: entry.journal)
            self._dateInput = State(initialValue: entry.date)
            self._totalChars = State(initialValue: entry.journal.count)
            self._promptQuestion = State(initialValue: entry.question)
            self._moodColorValue = State(initialValue: calculateMoodColor(emotionalVal: entry.emotionalLvl, sliderVal: entry.sliderVal))
            
        }

    
    var body: some View {
        
        NavigationView {
            SideBarStack(sidebarWidth: 125, showSidebar: $showSidebar) {
                // Sidebar content here
                SidebarContent().environmentObject(modelData)
            } content: {
                // Main content here
                ScrollView {
                    HStack {
                        Spacer()
                        VStack{
                            Spacer()
                            
                            Text(formateDate(date: entry.date))
                                .font(.largeTitle)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                            VStack{
                                Text("On this Day you felt:").font(.title).bold()
                                    .padding()
                                Slider(value: $emojiSlider,
                                       in: -10...10).tint(Color(.sRGB, red: 1.0, green: 0.1 + 0.7*(emojiSlider+10)/20, blue: 0.0, opacity: 1.0)).padding([.bottom, .trailing,.leading]).disabled(true)
                                
                            }.background(
                                Image("celestial").resizable().cornerRadius(15)
                            )
                            .padding()
                            

                            VStack {
                                    Text("\(promptQuestion)")
                                        .font(.title).bold()
                                        .padding([.top, .trailing,.leading]).fixedSize(horizontal: false, vertical: true)
                                

                                
                                

                                Text(String(entry.journal))
                                    .frame(width: 320, height: 45 + 45*CGFloat((totalChars/35)))
                                    .font(.title2)
                                    .multilineTextAlignment(.leading)
                                    .background(.white.opacity(0.3))
                                    .cornerRadius(15)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .onAppear() {
                                        UITextView.appearance().backgroundColor = UIColor.clear
                                    }

                                
                            }.background(
                                Image("redg").resizable().cornerRadius(15)
                            )
                            .padding()
                            
                            
                            VStack{
                                Text("Sentiment analysis has your journal mood at:").font(.title).bold().fixedSize(horizontal: false, vertical: true)
                                

                                    .padding()
                                Slider(value: $moodSlider,
                                       in: -1...1).tint(Color(.sRGB, red: 1.0, green: 0.1 + 0.7*(emojiSlider+10)/20, blue: 0.0, opacity: 1.0)).padding([.bottom, .trailing,.leading]).disabled(true)
                                
                            }.background(
                                Image("redg").resizable().cornerRadius(15)
                            )
                            .padding()
    //                        Spacer()
                            
                            VStack{
                                Text("Today's Mood Color").font(.title).bold()
                                    .padding()
                                    .frame(width: 350)


                                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: .vividOrange, location: 0-((moodColorValue)/22)), Gradient.Stop(color: .vividYellow, location: 1.8-((moodColorValue)/22))]), startPoint: .leading, endPoint: .trailing).frame(width: 300, height: 30, alignment: .center).cornerRadius(10).padding()


                            }.background(
                                Image("orangeg").resizable().cornerRadius(15)
                            )
                            
                        Spacer()

                            
    //                        .padding()
                        }.padding(.top)
                    }

                }
            }
            .edgesIgnoringSafeArea(.all).background(
                Image("darkbackground").resizable().ignoresSafeArea()
            )
        }.navigationBarHidden(true)
        
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(entry: ModelData().pastEntries[3]).environmentObject(ModelData())
    }
}
