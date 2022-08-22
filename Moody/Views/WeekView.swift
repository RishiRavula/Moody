//
//  WeekView.swift
//  Moody
//
//  Created by Loaner on 4/5/22.
//

import SwiftUI

struct WeekView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack {
            VStack {
                VStack{
                    LineGraphView(title: "Past Week Happiness", data: self.modelData.getSliderVals(from: Date().advanced(by: -(7 * 24 * 60 * 60)), to: Date()), maxValue: 10, scaleFactor: 10, width: 270, height: 240)
                }
                VStack{
                    LineGraphView(title: "Past Week Mood", data: self.modelData.getEmotionLevelVals(from: Date().advanced(by: -(7 * 24 * 60 * 60)), to: Date()), maxValue: 10, scaleFactor: 10, width: 270, height: 240)
                }
            }
        }.environmentObject(modelData)
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
