//
//  DataModel.swift
//  Moody
//
//  Created by Loaner on 3/14/22.
//

import Foundation
import SwiftUI
import UIKit



//UNIVERSAL URL TO PULL AND PUSH DATA TO ON THE SANDBOX


protocol Entry {
    var journal : String {get}
}

protocol EmotionBar{
    var sliderVal : Double {get}
}

protocol EntryDate {
    var date : Date {get}
}

protocol HappyVal{
    var emotionalLvl : Double {get}
}
class JournalEntries : EntryDate, Entry, EmotionBar, Codable, CustomStringConvertible{
    var date : Date = Date()
    var journal: String = ""
    var sliderVal: Double = 0
    var emotionalLvl = 0.0
    var question: String = ""
    var uniqueID : String = UUID().uuidString
    init() {
    }
    //Class Initalizer
    convenience init(_ date: Date, _ journal: String, _ sliderVal : Double, _ emotionalLvl : Double, _ question: String ) {
        self.init()
        self.date = date
        self.journal = journal
        self.sliderVal = sliderVal
        self.emotionalLvl = emotionalLvl
        self.question = question
    }
    convenience init(_ uniqueID : String){
        self.init()
        self.uniqueID = uniqueID
    }
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
        case journal = "journal"
        case sliderVal = "sliderVal"
        case emotionalLvl = "emotion"
        case question = "question"
        case uniqueID = "id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(journal, forKey: .journal)
        try container.encode(sliderVal, forKey: .sliderVal)
        try container.encode(emotionalLvl, forKey: .emotionalLvl)
        try container.encode(question, forKey: .question)
        try container.encode(uniqueID, forKey: .uniqueID)

    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        journal = try container.decode(String.self, forKey: .journal)
        sliderVal  = try container.decode(Double.self, forKey: .sliderVal)
        emotionalLvl = try container.decode(Double.self, forKey: .emotionalLvl)
        question =  try container.decode(String.self, forKey: .question)
        uniqueID = try container.decode(String.self, forKey: .uniqueID)
    }
    
        var description: String {
            let question = "Question of the day: \(question)  \n"
            let dateOfEntry = "Date: \(DateFormatter().string(from: date)).\n"
            let journalEntry = "Journal Entry: \(journal)\n"
            let emotionalValue = "Emotional Value: \(emotionalLvl).\n"
            let sliderValue = "Slider Value: \(sliderVal).\n"
            let uniqueID = "ID: \(uniqueID). \n"
            
            return question + dateOfEntry + journalEntry + emotionalValue + sliderValue + uniqueID
            
        }
    
    
}


