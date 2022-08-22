//
//  HelperFunctions.swift
//  Moody
//
//  Created by Loaner on 3/14/22.
//

import Foundation
import SwiftUI
import UIKit
import SwiftyJSON
import NotificationCenter

func APICall(entry:JournalEntries) -> Double {
    var emotionalVal : Double = 10.0
    let textToAnalyze = entry.journal
    let headers = [
        "content-type": "application/json",
        "X-RapidAPI-Host": "text-analysis12.p.rapidapi.com",
        "X-RapidAPI-Key": "{SECRET KEY NOT FOR VIEWING}"
    ]
    let parameters = [
        "language": "english",
        "text": "\(textToAnalyze)"
    ] as [String : Any]
    
    do{
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        let request = NSMutableURLRequest(url: NSURL(string: "https://text-analysis12.p.rapidapi.com/sentiment-analysis/api/v1.1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = data
                //print((String(decoding: httpResponse!, as: UTF8.self)))
                let toParse = (String(decoding: httpResponse!, as: UTF8.self))
                emotionalVal = updateEmotion(toParse: toParse)
                //print(emotionalVal)
                entry.emotionalLvl = emotionalVal
            }
        })
        dataTask.resume()
        
    }
    catch{
        print("couldn't post")
        return 0.0
    }
    return emotionalVal
}

func updateEmotion(toParse: String) -> Double{
    
    if let dataFromString = toParse.data(using: .utf8, allowLossyConversion: false) {
        do {
            let json = try JSON(data: dataFromString)
            if json["aggregate_sentiment"]["compound"].exists(){
                //HERE IS THE COMPOUND VALUE, - IS NEGATIVE + IS POSITIVE
                return json["aggregate_sentiment"]["compound"].double!
            }
        } catch {
            return 0.0
        }

    }
    return 0.0
}

func calculateMoodColor(emotionalVal : Double, sliderVal : Double) -> Double{
    let weighting = ((emotionalVal + 1)*10*0.65 + (sliderVal+10)*0.45)
    return weighting
}

func notificationPopUp() {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        
    }
    
    let content = UNMutableNotificationContent()
    content.title = "Message from Moody!"
    content.body = "Fill your entry today if you haven't already!"
    
    let noon = Calendar.current.startOfDay(for: Date()).addingTimeInterval(43200)
    let dateComp = Calendar.current.dateComponents([.hour], from: noon)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
    let uID = UUID().uuidString
    let request = UNNotificationRequest(identifier: uID, content: content, trigger: trigger)
    
    center.add(request) { (error) in
       print(error as Any)
    }
    
}








