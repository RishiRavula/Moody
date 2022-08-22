//
//  TrendView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/14.
//

import SwiftUI

struct TrendView: View {
    
    @StateObject var modelData: ModelData
    @State var showSidebar: Bool = false
    @State var pickerFlag: Int = 1
    
    var body: some View {
        
        NavigationView {
            
            SideBarStack(sidebarWidth: 125, showSidebar: $showSidebar) {
                // Sidebar content here
                SidebarContent().environmentObject(modelData)
            } content: {
                TabView{
                    MonthView()
                        .position(x: 200, y: 240)
                        .background(Image("darkbackground").resizable().ignoresSafeArea())
                        .tabItem{
                             Label("Past Month", systemImage: "list.dash")
                                .background(.white)
                        }
                    WeekView()
                        .position(x: 200, y: 240)
                        .background(Image("darkbackground").resizable().ignoresSafeArea())
                        .tabItem{
                            Label("Past Week", systemImage: "list.dash")
                        }
                    CustomDatesView()
                        .preferredColorScheme(.dark)
                        .background(Image("darkbackground").resizable().ignoresSafeArea())
                        .tabItem{
                            Label("Custom", systemImage: "list.dash")
                                .foregroundColor(.white)
                        }
                }
                .accentColor(.orange)
                .foregroundColor(.teal)
                
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


struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView(modelData: ModelData()).environmentObject(ModelData())
    }
}
