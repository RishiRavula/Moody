//
//  LineGraphHelpers.swift
//  Moody
//
//  Created by Loaner on 3/31/22.
//

import Foundation

func getSliderValuesArray(data: [JournalEntries]) -> [Double]{
    var result: [Double] = []
    for i in 0..<data.count{
        result.append(data[i].sliderVal)
    }
    return result
}

func getEmotionLevelValuesArray(data: [JournalEntries]) -> [Double]{
    var result: [Double] = []
    for i in 0..<data.count{
        result.append(data[i].emotionalLvl * 10)
    }
    return result
}

//var sliderVals: [Double] = getSliderValuesArray(data: ModelData().pastEntries)
//var emotionVals: [Double] = getEmotionLevelValuesArray(data: ModelData().pastEntries)

