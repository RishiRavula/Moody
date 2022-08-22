//
//  EntryRowView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/28.
//

import SwiftUI
let dateFormatter = DateFormatter()

struct EntryRowView: View {
    var entry: JournalEntries
    @EnvironmentObject var modelData: ModelData
    

    
    var body: some View {
       
 
            HStack {
                
//                Circle()
//                    .fill(
//                        RadialGradient(gradient: Gradient(colors: [.coolBlue, .coolPurple]),  center: .center, startRadius: 0, endRadius: 30)
//                    )
//                    .frame(width: 40, height: 40)

//                Text(formateDate(date: entry.date))
                Spacer()

                if entry.emotionalLvl > 0 {
                    Text("😃").scale(2.5).padding()
                    
                } else {
                    Text("😢").scale(2.5).padding()


                }
                
                

                Text(entry.question)
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding([.trailing,.leading])
                Spacer()
//                Text(" " + String(format: "%.2f", entry.sliderVal))
//
//                Text(" " + String(format: "%.2f", entry.sliderVal))

    //            Text(entry.sliderVal)

            }
        

    }
}

struct EntryRowView_Previews: PreviewProvider {
    static var previews: some View {
        EntryRowView(entry: ModelData().pastEntries[0]).environmentObject(ModelData())           .previewLayout(.fixed(width:300,height:70))
    }
}

func formateDate(date: Date) -> String {
    dateFormatter.dateFormat = "YY/MM/dd"
    return dateFormatter.string(from: date)
}

extension Color {
    static let vividYellow = Color(red: 255 / 255, green: 228 / 255, blue: 2 / 255)
    static let vividOrange = Color(red: 254 / 255, green: 95 / 255, blue: 3 / 255)
    static let coolPurple = Color(red: 56 / 255, green: 0 / 255, blue: 54 / 255)
    static let coolBlue = Color(red: 12 / 255, green: 186 / 255, blue: 186 / 255)

}
