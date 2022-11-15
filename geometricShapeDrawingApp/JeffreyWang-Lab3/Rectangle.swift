//
//  Rectangle.swift
//  JeffreyWang-Lab3
//
//  Created by Ziqian Wang on 10/7/22.
//

import UIKit

class Rectangle: Shape {
    
    public required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
        self.size = 100
        self.angle = 0
    }
    
    override func draw(){ //rectangle
        path = UIBezierPath()
        
        path.move(to: CGPoint(x: origin.x - size/2, y: origin.y - size/2))
        path.addLine(to: CGPoint(x: origin.x + size/2, y: origin.y - size/2))
        path.addLine(to: CGPoint(x: origin.x + size/2, y: origin.y + size/2))
        path.addLine(to: CGPoint(x: origin.x - size/2, y: origin.y + size/2))
        path.close()
        
        path.rotate(by: angle)
        path.scaleAroundCenter(factor: scale)
        
        color.setFill()
        path.fill()
    }
}
