//
//  painterUIV.swift
//  image painter
//
//  Created by user on 2017/6/29.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class paintUIV: UIView {

    
    private var context:CGContext?
    private var isInit:Bool = false
    private var lines:[Int:Array<(CGFloat,CGFloat)>] = [0:[]]
    private var line:Array<(CGFloat,CGFloat)> = []
    private var lineCount = 0
    private var relines:[Int:Array<(CGFloat,CGFloat)>] = [0:[]]
    private var relineCount = 0
    private var typedraw:Int = 0
    private var proplines:[Int:Int] = [0:0]
    private var viewW:CGFloat?
    private var viewH:CGFloat?
    
    
    
//-------------------init------------------------
    private func drawInit(_ rect:CGRect){
        isInit = true
        context = UIGraphicsGetCurrentContext()
        viewW = rect.size.width
        viewH = rect.size.height
    }
    
    
    func changeType(_ num:Int){
        typedraw = num
    }

    
//-------------------主界面------------------------
    func updo(){
        if lineCount > 0 {
            relineCount += 1
            relines[relineCount] = lines.removeValue(forKey: lineCount)
            lineCount -= 1
            setNeedsDisplay()
        }
    }
    
    func redo(){
        if relineCount > 0{
            lineCount += 1
            lines[lineCount] = relines.removeValue(forKey: relineCount)
            relineCount -= 1
            setNeedsDisplay()
        }
        
    }
    func clear(){
        lines = [0:[]]
        lineCount = 0
        setNeedsDisplay()
    }
    
//-------------------draw------------------------
    override func draw(_ rect: CGRect) {
        
        if !isInit {drawInit(rect)}
        
        for name in 1..<lines.count{
            
            if lines[name]!.count < 1 {continue}
            
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
            
            
            let typedrawTemp:Int = proplines[name] ?? 0
            
            switch typedrawTemp {
            case 1:
                linesAPI.randrectLine(name, lines: lines, context: context)
            case 2:
                linesAPI.rectLine(name, lines: lines, context: context)
            case 3:
                linesAPI.triLine(name, lines: lines, context: context)
            default:
                linesAPI.normalLine(name, lines: lines, context: context)
                
            }
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        
    }
    
//    func normalLine(_ name:Int,lines:[Int:Array<(CGFloat,CGFloat)>],context:CGContext?){
//        let (p0x,p0y) = lines[name]![0]
//        
//        context?.move(to: CGPoint(x:p0x,y:p0y))
//        
//        var i = 1
//        while i < lines[name]!.count {
//            let (p1x,p1y) = lines[name]![i]
//            context?.addLine(to: CGPoint(x:p1x,y:p1y))
//            i += 1
//        }
//        
//    }
    
//-------------------紀錄點------------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        relines = [0:[]]
        relineCount = 0
        lineCount += 1
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        proplines[lineCount] = typedraw
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: self)
        line.append((point!.x,point!.y))
        lines[lineCount] = line
        line = []
        setNeedsDisplay()
    }
    
}
