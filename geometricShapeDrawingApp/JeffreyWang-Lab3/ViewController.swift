//
//  ViewController.swift
//  JeffreyWang-Lab3
//
//  Created by Ziqian Wang on 10/5/22.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var currentShape:Shape?
    var currentMovingShape:Shape?
    var currentItem:Shape?
    var currentColor: UIColor?
    var currentMode: String?
    var trackingShape: String?
    var scaleStored:CGFloat = 1.0
    
    @IBOutlet weak var canvasFrame: UIView!
    @IBOutlet weak var drawingCanvas: DrawingView!
    //segmented controls
    @IBOutlet weak var operationStack: UIStackView!
    @IBOutlet weak var colorControl: UISegmentedControl!
    @IBOutlet weak var shapeControl: UISegmentedControl!
    @IBOutlet weak var actionControl: UISegmentedControl!
    @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
    @IBOutlet var rotateGesture: UIRotationGestureRecognizer!
    //creative
    @IBOutlet weak var opacitySlide: UISlider!
    
    //func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up gesture
        rotateGesture.delegate = self
        pinchGesture.delegate = self
        
        //set up drawing canvas
        drawingCanvas.backgroundColor = UIColor.clear
        
        //other setup
        currentColor = UIColor.systemRed.withAlphaComponent(1)
        trackingShape = "Rectangle"
        currentMode = "Draw"
        
    }
    
    //clear all
    @IBAction func clearStuff(_ sender: Any) {
        currentShape = nil
        drawingCanvas.items = []
    }
    
    
//selections
    //select a color
    let colors:[UIColor] = [.systemRed,.systemYellow,.systemGreen,.systemBlue,.systemPurple,.systemRed]
    
    @IBAction func selectColor(_ sender: UISegmentedControl) {
            currentColor = colors[sender.selectedSegmentIndex]
            print(currentColor ?? .clear)
    }
    //select a shape
    let shapes:[String] = ["Rectangle","Circle","Triangle"]
    @IBAction func selectShape(_ sender: UISegmentedControl) {
        trackingShape = shapes[sender.selectedSegmentIndex]
        print(trackingShape ?? "null")
    }
    //select a mode
    let modes:[String] = ["Draw","Move","Erase","Color","Opacity"]
    @IBAction func selectMode(_ sender: UISegmentedControl) {
        currentMode = modes[sender.selectedSegmentIndex]
        print(currentMode ?? "null")
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {return true}
    
//touches
    //touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingCanvas)
        else{ return }
        
        if (currentMode == "Draw"){
            print(touchPoint)
            if (trackingShape == "Rectangle"){
                currentShape = Rectangle(origin: touchPoint, color: currentColor ?? .systemRed)
            }
            if (trackingShape == "Circle"){
                currentShape = Circle(origin: touchPoint, color: currentColor ?? .systemRed)
            }
            if (trackingShape == "Triangle"){
                currentShape = Triangle(origin: touchPoint, color: currentColor ?? .systemRed)
            }
        }
        if (currentMode == "Move"){
            currentMovingShape = drawingCanvas.itemAtLocation(touchPoint) as? Shape
            currentShape = currentMovingShape
        }
        
        if (currentMode == "Erase"){
            
            var itemIndex = -1
            var indexCount = drawingCanvas.items.count
            print(touchPoint)
            for item in drawingCanvas.items.reversed(){
                if (item.contains(point: touchPoint)){
                    itemIndex = indexCount-1
                    break
                }
                indexCount -= 1
            }
            drawingCanvas.items.remove(at: itemIndex)
            print(drawingCanvas.items)
        }
        
        if (currentMode == "Color"){
            currentMovingShape = drawingCanvas.itemAtLocation(touchPoint) as? Shape
            currentShape = currentMovingShape
            currentShape?.color = currentColor ?? .black
        }
        
        if (currentMode == "Opacity"){
            currentMovingShape = drawingCanvas.itemAtLocation(touchPoint) as? Shape
            currentShape = currentMovingShape
            let colorStored = currentShape?.color
            currentShape?.color = colorStored?.withAlphaComponent(CGFloat(opacitySlide.value)) ?? .black
        }
        
    }
    
    //touchesMoved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
        let touchPoint = touches.first?.location(in: drawingCanvas)
        else{ return }
        
        if (currentMode == "Move"){
            currentShape?.origin = touchPoint
            drawingCanvas.setNeedsDisplay()
        }
    }
    
    //touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let newShape = currentShape{
            drawingCanvas.items.append(newShape)
        }
    }
    
    @IBAction func pinched(_ sender: UIPinchGestureRecognizer) {
        print("inside pinch")
        
        if (currentMode == "Move") {
            var scaleChange = sender.scale
            scaleChange = scaleChange / scaleStored
            currentShape?.scale = sender.scale
            currentShape?.path.scaleAroundCenter(factor: scaleChange)
            drawingCanvas.setNeedsDisplay()
        }
        else{
            return
        }
    }
    
    @IBAction func rotated(_ sender: UIRotationGestureRecognizer) {
        print("inside rotate")
        if (currentMode == "Move") {
            
            guard sender.view != nil else {
                return
            }
            
            if (sender.state == .began || sender.state == .changed) {
                let touchPoint = sender.location(in: drawingCanvas)
                let currentShape = drawingCanvas.itemAtLocation(touchPoint) as? Shape
                currentShape?.angle = sender.rotation
                
                drawingCanvas.setNeedsDisplay()
            }
            
        }else{
            return
        }
    }
    
    

    
    

    }

