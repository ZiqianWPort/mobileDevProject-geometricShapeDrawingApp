//
//  Shape.swift
//  CSE 438S Lab 3
//
//  Created by Michael Ginn on 5/31/21.
//

import UIKit

/**
 YOU SHOULD MODIFY THIS FILE.
 
 Feel free to implement it however you want, adding properties, methods, etc. Your different shapes might be subclasses of this class, or you could store information in this class about which type of shape it is. Remember that you are partially graded based on object-oriented design. You may ask TAs for an assessment of your implementation.
 */

/// A `DrawingItem` that draws some shape to the screen.
class Shape: DrawingItem {
    
    var origin:CGPoint
    var color:UIColor
    var path = UIBezierPath()
    var size:CGFloat = 0
    var angle:CGFloat = 0
    var scale:CGFloat = 1
    

    public required init(origin: CGPoint, color: UIColor){
        self.origin = origin
        self.color = color
    }

    func draw() {
        self.draw()
    }

    func contains(point: CGPoint) -> Bool {
        return path.contains(point)
    }
}

extension UIBezierPath {
    
    //from https://stackoverflow.com/questions/20400396/reposition-resize-uibezierpath
    
    func scaleAroundCenter(factor: CGFloat) {
        let beforeCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let scaleTransform = CGAffineTransform(scaleX: factor, y: factor)
        self.apply(scaleTransform)
        let afterCenter = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let diff = CGPoint( x: beforeCenter.x - afterCenter.x, y: beforeCenter.y - afterCenter.y)

        let translateTransform = CGAffineTransform(translationX: diff.x, y: diff.y)
        self.apply(translateTransform)
        
    }
    
    func rotate(by angleRadians: CGFloat){
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: angleRadians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        self.apply(transform)
    }
    
    func moveHelper(from:CGPoint, to:CGPoint){
        let distance = CGPoint( x: to.x - from.x, y: to.y - from.y)
        self.apply(CGAffineTransform(translationX: distance.x, y: distance.y))
    }


}
