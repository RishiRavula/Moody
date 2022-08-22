//
//  MonthView.swift
//  Moody
//
//  Created by Loaner on 4/5/22.
//

import SwiftUI

struct MonthView: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        VStack {
            //MARK: Calling the Line graphs here with the specified value
            LineGraphView(title: "Past Month Happiness", data: self.modelData.getSliderVals(from: Date().advanced(by: -(30 * 24 * 60 * 60)), to: Date()), maxValue: 10, scaleFactor: 10, width: 270, height: 240)
            LineGraphView(title: "Past Month Mood", data: self.modelData.getEmotionLevelVals(from: Date().advanced(by: -(30 * 24 * 60 * 60)), to: Date()), maxValue: 10, scaleFactor: 10, width: 270, height: 240)
        }.environmentObject(modelData)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
    }
}
