//
//  MoodyApp.swift
//  Moody
//
//  Created by Loaner on 3/13/22.
//

import SwiftUI

@main
struct MoodyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ModelData())
        }
    }
}
