//
//  CustomDatesView.swift
//  Moody
//
//  Created by Loaner on 4/5/22.
//

import SwiftUI

struct CustomDatesView: View {
    @State var fromDate = Date()
    @EnvironmentObject var modelData: ModelData
    @State var toDate = Date()
    
    var dateClosedRange: ClosedRange<Date> {
        let min = fromDate
        // Converting seconds to days by num_days * 24 * 60 * 60
        var max = fromDate.advanced(by: 30 * 24 * 60 * 60)
        max = (max > Date()) ? Date() : max
        return min...max
    }
    
    var todayDateRange: ClosedRange<Date>{
        let min = Date(timeIntervalSince1970: 0)
        let max = Date.now
        return min...max
    }
    
    
    var computeDifference: Double {
        get{
            return toDate.timeIntervalSince(fromDate) / (24*60*60)
        }
    }
    
    var body: some View {
        VStack(/*alignment: .center, spacing: 0.0*/){
            HStack{
                HStack {
                    Text("From: ")
                        .font(.title3)
                    DatePicker(selection: $fromDate, in: todayDateRange, displayedComponents: .date, label: {
                        Text("")
                    })
                        .preferredColorScheme(.dark)
                }
                .padding(.leading)
                HStack {
                    Text("To: ")
                        .font(.title3)
                    DatePicker(selection: $toDate, in: dateClosedRange, displayedComponents: .date, label: {
                        Text("")
                    })
                        .preferredColorScheme(.dark)
                }
                .padding(.trailing)
            }
            Group {
                LineGraphView(title: "Happiness", data: self.modelData.getSliderVals(from: fromDate, to: toDate), maxValue: 10, scaleFactor: 10, width: 260, height: 200)
                LineGraphView(title: "Mood", data: self.modelData.getEmotionLevelVals(from: fromDate, to: toDate), maxValue: 10, scaleFactor: 10, width: 260, height: 200)
            }
            .environmentObject(modelData)
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct CustomDatesView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatesView()
    }
}
