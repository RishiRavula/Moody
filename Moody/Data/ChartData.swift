//
//  ChartData.swift
//  Moody
//
//  Created by Loaner on 3/20/22.
//

import Foundation

struct ChartData {
    var label: String
    var value: Double
}

let chartDataSet = [
    ChartData(label: "January 2021", value: -30.32),
    ChartData(label: "February 2021", value: 250.0),
    ChartData(label: "March 2021", value: 430.22),
    ChartData(label: "April 2021", value: -350.0),
    ChartData(label: "May 2021", value: -450.0),
    ChartData(label: "June 2021", value: 380.0),
    ChartData(label: "July 2021", value: 365.98)
]

var defaultEntries: [JournalEntries] = [
    JournalEntries(Date()," 1hello journal entry", -3.0, 1, "" ),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 1, to: Date())!," 2 hello journal entry", -10.0, -0.2, ""),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 2, to: Date())!,"3 hello journal entry", 0, 0.10, "" ),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 3, to: Date())!,"4 hello journal entry", 2.2, 0.2 , "" ),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 4, to: Date())!,"5 hello journal entry", -10.0, 0.3 , "" ),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 5, to: Date())!,"6 hello journal entry", 10, -0.4, "" ),
    JournalEntries(Calendar.current.date(byAdding: .day, value: 6, to: Date())!,"7 hello journal entry", 2.2, -0.10, "" ),
//    JournalEntries(Date()," 1hello journal entry", -3.0, 1 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 1, to: Date())!," 2 hello journal entry", -10.0, -0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 2, to: Date())!,"3 hello journal entry", 0, 0.10 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 3, to: Date())!,"4 hello journal entry", 2.2, 0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 4, to: Date())!,"5 hello journal entry", -10.0, 0.3 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 5, to: Date())!,"6 hello journal entry", 10, -0.4),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 6, to: Date())!,"7 hello journal entry", 2.2, -0.10),
//    JournalEntries(Date()," 1hello journal entry", -3.0, 1 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 1, to: Date())!," 2 hello journal entry", -10.0, -0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 2, to: Date())!,"3 hello journal entry", 0, 0.10 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 3, to: Date())!,"4 hello journal entry", 2.2, 0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 4, to: Date())!,"5 hello journal entry", -10.0, 0.3 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 5, to: Date())!,"6 hello journal entry", 10, -0.4),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 6, to: Date())!,"7 hello journal entry", 2.2, -0.10),
//    JournalEntries(Date()," 1hello journal entry", -3.0, 1 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 1, to: Date())!," 2 hello journal entry", -10.0, -0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 2, to: Date())!,"3 hello journal entry", 0, 0.10 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 3, to: Date())!,"4 hello journal entry", 2.2, 0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 4, to: Date())!,"5 hello journal entry", -10.0, 0.3 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 5, to: Date())!,"6 hello journal entry", 10, -0.4),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 6, to: Date())!,"7 hello journal entry", 2.2, -0.10),
//    JournalEntries(Date()," 1hello journal entry", -3.0, 1 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 1, to: Date())!," 2 hello journal entry", -10.0, -0.2 ),
//    JournalEntries(Calendar.current.date(byAdding: .day, value: 2, to: Date())!,"3 hello journal entry", 0, 0.10 )
]
