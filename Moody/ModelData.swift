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
var simpleSaveURL: URL = ModelData().getDocumentsDirectory().appendingPathComponent("journalentries.txt")

final class ModelData: ObservableObject {
    
    private static var defaultEntries: [JournalEntries] = [
    ]
        
    //THE MAIN DATA STORAGE MODEL HERE
    @Published var pastEntries: [JournalEntries] = defaultEntries
    
    func getSliderVals(from start_date: Date, to end_date: Date) -> [Double]{
        var dateComp = Calendar.current.dateComponents([.day, .month, .year, .timeZone], from: start_date)
        dateComp.hour = -5
        dateComp.minute = 0
        let actualStartDate = Calendar.current.date(from: dateComp) ?? start_date
        
        var endDateComp = Calendar.current.dateComponents([.day, .month, .year, .timeZone], from: end_date)
        endDateComp.hour = 19
        endDateComp.minute = 59
        endDateComp.second = 59
        let actualEndDate = Calendar.current.date(from: endDateComp) ?? end_date
        
        var result: [Double] = []
        for i in 0..<self.pastEntries.count{
            if self.pastEntries[i].date >= actualStartDate && self.pastEntries[i].date <= actualEndDate {
                var newValue = min(self.pastEntries[i].sliderVal, 10)
                if(pastEntries[i].sliderVal < -10){
                    newValue = -10
                }
                result.append(newValue)
            }
        }
        return result
    }
    
    func getEmotionLevelVals(from start_date: Date, to end_date: Date) -> [Double]{
        var dateComp = Calendar.current.dateComponents([.day, .month, .year, .timeZone], from: start_date)
        dateComp.hour = -5
        dateComp.minute = 0
        let actualStartDate = Calendar.current.date(from: dateComp) ?? start_date
        
        var endDateComp = Calendar.current.dateComponents([.day, .month, .year, .timeZone], from: end_date)
        endDateComp.hour = 19
        endDateComp.minute = 59
        endDateComp.second = 59
        let actualEndDate = Calendar.current.date(from: endDateComp) ?? end_date
        
        var result: [Double] = []
        for i in 0..<self.pastEntries.count{
            if self.pastEntries[i].date >= actualStartDate && self.pastEntries[i].date <= actualEndDate{
                var appendValue = min(self.pastEntries[i].emotionalLvl * 10 , 10)
                if(self.pastEntries[i].emotionalLvl * 10 < -10){
                    appendValue = -10
                }
                result.append(appendValue)
            }
        }
        return result
    }
    
    //TO SAVE ALL CURRENT ENTRIES THAT EXIST IN pastEntries CALL save()
    func save(entries: [JournalEntries]){
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(entries)
        
        do {
            try jsonData?.write(to: simpleSaveURL)
            print(simpleSaveURL)

            } catch let error {
                print("Save could not be executed")
                let err : Error? = error
                print(err as Any )
            }
    }


    //TO LOAD DATA FROM STORAGE IF IT EXISTS, CALL THIS FUNCTION load()
    func load(){
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: simpleSaveURL.path) {
            print("File Exists, pulling from sandbox")
            do {
                pastEntries.removeAll()
                guard let file = try? FileHandle(forReadingFrom: simpleSaveURL) else {
                    print("error pulling data")
                    return
                }
                let loadEntries = try JSONDecoder().decode([JournalEntries].self, from: file.availableData)
                
                pastEntries = loadEntries
                let jsonEncoder = JSONEncoder()
                let jsonData = try? jsonEncoder.encode(pastEntries)
                let jsonString = String(data: jsonData!, encoding: .utf8)
                print(jsonString ?? "NIL")
            }
            catch {
                print("error")
            }
        }
    }

    //URL logic to save to sandbox
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    

}






