//
//  SidebarContent.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/14.
//

import SwiftUI
import VTabView


struct SidebarContent: View {
    @EnvironmentObject var modelData: ModelData

    init(){
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        VStack(alignment: .leading) {

            HStack {
                NavigationLink(destination: JournalView().environmentObject(modelData)) {
                    Text("Journal")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.isDetailLink(false)
            }
                .padding(.top, 120)


            HStack {
                NavigationLink(destination: TrendView(modelData: modelData).environmentObject(modelData)) {
                    Text("Trends")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.isDetailLink(false)
            }
                .padding(.top, 30)


            HStack {
                NavigationLink(destination: EntriesView().environmentObject(modelData).onAppear(perform: modelData.load)) {
                    Text("Past Entries")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.isDetailLink(false)
            }
            .padding(.top, 30)




            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)

//
//        VTabView {
//            Text("The First Tab")
//                .tabItem {
//                    Image(systemName: "square.fill")
//                }
//            Text("Another Tab")
//                .tabItem {
//                    Image(systemName: "circle.fill")
//                }
//            Text("The Last Tab")
//                .tabItem {
//                    Image(systemName: "triangle.fill")
//                }
//        }
//

        
    }
}

struct SidebarContent_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContent().environmentObject(ModelData())
    }
}
