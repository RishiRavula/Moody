//
//  ContentView.swift
//  Moody
//
//  Created by Loaner on 3/13/22.
//

import SwiftUI
struct ContentView: View {
    
    
    
    @State var emojiSlider: Double = 5
    @State var showSidebar: Bool = false

    @EnvironmentObject var modelData: ModelData

    
    var body: some View {
        JournalView(showSidebar: false).environmentObject(modelData).onAppear(perform: notificationPopUp)
    }

    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
