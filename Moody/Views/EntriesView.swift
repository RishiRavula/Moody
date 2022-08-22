//
//  EntriesView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/14.
//

import SwiftUI

struct EntriesView: View {
    
    @State var showSidebar: Bool = false
    @EnvironmentObject var modelData: ModelData
    @State var listview = ModelData().pastEntries

    var body: some View {
        
        NavigationView {
        
            SideBarStack(sidebarWidth: 125, showSidebar: $showSidebar) {
                // Sidebar content here
                SidebarContent().environmentObject(modelData)
            } content: {
               // Main content here
                NavigationView {
                    
                    VStack{
                        
                        Text("Past Journal Entries")
                            .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .offset(y:-70)

                        
                        
                        ZStack {
                            
                            List {
                                ForEach(modelData.pastEntries, id: \.uniqueID) {eachEntry in
                                    EntryListView(entry: eachEntry).listRowBackground(
                                        
                                        LinearGradient(gradient: Gradient(stops: [
                                        
                                            Gradient.Stop(color: .vividOrange, location: 0-(eachEntry.sliderVal)/20 ),
                                        Gradient.Stop(color: .vividYellow, location: 1-(eachEntry.sliderVal)/20),


                                    ]), startPoint: .leading, endPoint: .trailing)).environmentObject(modelData)
                                    
                                }
                            }.onAppear() {
                                UITableView.appearance().backgroundColor = UIColor.clear
                            }

                        }

                    }.background(
                        Image("darkbackground").resizable().ignoresSafeArea())
                }
            }
            
            .edgesIgnoringSafeArea(.all)
        
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showSidebar.toggle()
                    }

                }) {
                    Image(systemName: "line.horizontal.3").scaleEffect(1.5)
                        .foregroundColor(Color(.gray))

                }
            ))
        }.navigationBarHidden(true)


    }
}

struct EntriesView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView().environmentObject(ModelData())
    }
}
