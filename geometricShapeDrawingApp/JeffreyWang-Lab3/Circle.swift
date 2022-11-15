//
//  Circle.swift
//  JeffreyWang-Lab3
//
//  Created by Ziqian Wang on 10/7/22.
//

import UIKit

class Circle: Shape {
    
    public required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
        self.size = 100
        self.angle = 0
    }
    
    override func draw(){ //circle
        path = UIBezierPath()
        
        path.addArc(withCenter: origin, radius: size/2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        
        path.rotate(by: angle)
        path.scaleAroundCenter(factor: scale)
        
        color.setFill()
        path.fill()
    }
}
