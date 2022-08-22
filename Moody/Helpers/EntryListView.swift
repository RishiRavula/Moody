//
//  EntryListView.swift
//  Moody
//
//  Created by Stuart Tsao on 2022/3/28.
//

import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var modelData: ModelData
    @State var isAlertPresented: Bool = false
    @State var isAlert2Presented: Bool = false
    
    @State var editIsActive = false
    @State var showNewView = false

    @State private var showSheet = false
    @State var notdeleted = true
    var entry: JournalEntries
    
    var body: some View {
        
        
        if notdeleted {

            
                Section(header: Text(formateDate(date: entry.date))                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                ) {
                    
                    
                    NavigationLink {

                        EntryView(entry: entry).environmentObject(modelData)


                    } label: {
                        EntryRowView(entry: entry).environmentObject(modelData)
                        
                    }.swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            
                            isAlertPresented = true

                          } label: {
                           Label("Delete", systemImage: "trash")
                          }
                          .tint(.red)
                        
                        Button(role: .cancel) {
                            
                            isAlertPresented = false
                            editIsActive = true

                        } label: {
                         Label("Edit", systemImage: "edit")
                        }
                        .tint(.gray)
                        
                    }
                    .alert("Are you sure?", isPresented: $isAlertPresented) {
                        Button("Yes") {
                            
                            withAnimation{
                                modelData.pastEntries.removeAll(where: { $0.uniqueID == entry.uniqueID})
                                modelData.save(entries: modelData.pastEntries)
                            }
                            notdeleted = false
                        }
                        Button("No") {
                            
                        }
                    }
                }.headerProminence(.increased)
                .sheet(isPresented: $editIsActive) {
                EditEntryView(entry: entry).environmentObject(modelData)
            }
            }
            
    }
    }


struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(entry: ModelData().pastEntries[0]).environmentObject(ModelData())
    }
}


