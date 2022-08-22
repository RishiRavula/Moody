//
//  LineGraphView.swift
//  BarChartPractic
//
//  Created by Loaner on 3/31/22.
//

import SwiftUI

struct LineGraphView: View {
    var title: String
    var data: [Double]
    var maxValue: Int
    var scaleFactor: Int
    var width: Int
    var height: Int
    
    @State var currentPlot: String = ""
    @State var positionThing: CGPoint = .zero
    @State var showPlotFlag = false
    
    
    init(title: String, data: [Double], maxValue: Int, scaleFactor: Int, width: Int, height: Int){
        self.title = title
        self.data = data
        self.maxValue = maxValue
        self.scaleFactor = scaleFactor
        self.width = width
        self.height = height
    }
    
    var body: some View {
        VStack(/*spacing: 0.0*/){
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.cgDarkGray)
                    .padding(.all)
                    .brightness(0.3)
//                Spacer()
            }
            VStack {
                HStack {
                    ZStack {
                        axes(count: data.count)
                            .stroke(.white, lineWidth: 3)
                        GeometryReader { geometry in
                            ZStack {
                                lineGraph(debug: true, data: data, maxValue: maxValue, scaleFactor: scaleFactor)
                                    .stroke(Color.cgDarkGray, lineWidth: 2)
                                LinearGradient(colors:[
                                    Color.yellow,
                                    Color.red
                                ], startPoint: .top, endPoint: .bottom)
                                    .clipShape(
                                        Path{path in
                                            path.move(to: CGPoint(x: 0, y: 0))
                                            let points = lineGraph.returnPoints(in: CGRect(x: 0, y: 0, width: width, height: height), data: data, maxValue: maxValue, scaleFactor: scaleFactor)
                                            path.addLines(points)
                                            path.addLine(to: CGPoint(points[points.count - 1].x , geometry.size.height/2))
                                        }
                                    )
                            }
                            .overlay(
                                VStack(spacing: 0){
                                    Text(currentPlot)
                                        .font(.caption.bold())
                                        .foregroundColor(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 10)
                                        .background(Color.purple, in: Capsule())
                                    
                                    Rectangle()
                                        .fill(Color.purple)
                                        .frame(width: 1, height: 40)
                                        .padding(.top)
                                    
                                    Circle()
                                        .fill(Color.pink)
                                        .frame(width: 22, height: 22)
                                        .overlay(
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 10, height: 10)
                                        )
                                    
                                    Rectangle()
                                        .fill(Color.purple)
                                        .frame(width: 1, height: 50)
                                    
                                }
                                    .position(x: positionThing.x, y: positionThing.y - 12)
                                //                                    .frame(width: 80, height: 170)
                                    .opacity(showPlotFlag ? 1 : 0)
                            )
                            .contentShape(Rectangle())
                            .gesture(DragGesture().onChanged({ value in
                                if data.count > 0{
                                    withAnimation{showPlotFlag = true}
                                    let translation_offset = 40.0
                                    
                                    let translation = value.location.x - translation_offset
                                    //                                print(value.location.x, width)
                                    
                                    let index = max(min(Int(((translation) / Double((width))) * Double(data.count)), data.count - 1), 0)
                                    let newValue = Double(round(100 * data[index]) / 100)
                                    currentPlot = "\(newValue)"
                                    
                                    let allPoints = lineGraph.returnPoints(in: CGRect(x: 0, y: 0, width: width, height: height), data: data, maxValue: maxValue, scaleFactor: scaleFactor)
                                    
                                    positionThing = allPoints[index  + 1]
                                    
                                }
                            }).onEnded({ value in
                                withAnimation{showPlotFlag = false}
                            }))
                        }
                    }
                    .overlay(
                        VStack{
                            Rectangle()
                                .stroke(.secondary, lineWidth: 1)
                                .frame(width: CGFloat(width) * 1.3, height: CGFloat(height) * 1.1, alignment: .trailing)
                        }
                    )
                    .frame(width: CGFloat(width), height: CGFloat(height), alignment: .center)
                }
            }
        }
    }
}

//struct LineGraphView_Previews: PreviewProvider {
//    static var previews: some View {
////        LineGraphView(title: "Analytics", data: , maxValue: 10, scaleFactor: 10, width: 300, height: 200)
////.previewInterfaceOrientation(.portraitUpsideDown)
//    }
//}
