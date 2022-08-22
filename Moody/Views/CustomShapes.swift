//
//  CustomShapes.swift
//  BarChartPractic
//
//  Created by Loaner on 3/31/22.
//

import Foundation
import PureSwiftUI


private typealias Curve = (p:CGPoint, cp1: CGPoint, cp2: CGPoint)



struct lineGraph: Shape{
    let debug: Bool
    var data: [Double]
    var maxValue: Int
    var scaleFactor: Int
    var graphLayoutConfig: LayoutGuideConfig

    
    init(debug: Bool, data: [Double], maxValue: Int, scaleFactor: Int){
        self.debug = debug
        self.data = data
        self.maxValue = maxValue
        self.scaleFactor = scaleFactor
        graphLayoutConfig = LayoutGuideConfig.grid(columns: data.count, rows: 200)
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = graphLayoutConfig.layout(in: rect)
        
        var points: [CGPoint] = [g[0, 100]]
        for i in 0..<data.count{
            //Might need fixing later since it needs converting to Int
            //Potential Solution: multiply no rows by 10 and emotionalLvl by 10
            points.append(g[i + 1, (maxValue - Int(data[i])) * scaleFactor])
        }
        
        var curves = [Curve]()
        
        for i in 1..<points.count{
            curves.append(Curve(points[i], points[i - 1], points[i]))
        }
        //If you uncomment the next line, it will make a shape, which is not what we want
        //                curves.append(Curve(points[0], points[defaultEntries.count - 1], points[0]))
        
        path.move(points[0])
        
        for curve in curves{
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: debug)
        }
        
        return path.strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
    }
    
    static func returnPoints(in rect: CGRect, data: [Double], maxValue: Int, scaleFactor: Int) -> [CGPoint]{
        let subg = LayoutGuideConfig.grid(columns: data.count, rows: 200)
        let g = subg.layout(in: rect)
        var points: [CGPoint] = [g[0, 100]]
        for i in 0..<data.count{
            //Might need fixing later since it needs converting to Int
            //Potential Solution: multiply no rows by 10 and emotionalLvl by 10
            points.append(g[i + 1, (maxValue - Int(data[i])) * scaleFactor])
        }
        return points
    }
}

struct axes: Shape{
    var count: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let subg = LayoutGuideConfig.grid(columns: count, rows: 200)
        let g = subg.layout(in: rect)
        
        var points: [CGPoint] = []
        
        points.append(g[0,0])
        points.append(g[0,200])
        points.append(g[0,100])
        points.append(g[count ,100])
        points.append(g[0,100])
        points.append(g[0,200])
        
        path.move(points[0])
        
        for i in 1..<points.count - 1{
            path.addLine(to: points[i + 1])
        }
        
        return path
    }
}

