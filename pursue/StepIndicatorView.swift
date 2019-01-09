//
//  StepIndicatorView.swift
//  Inpursuit
//
//  Created by Jaylen Sanders on 1/8/19.
//  Copyright © 2019 Glory. All rights reserved.
//

import UIKit

public enum StepIndicatorViewDirection:UInt {
    case leftToRight = 0, rightToLeft, topToBottom, bottomToTop
}


@IBDesignable
public class StepIndicatorView: UIView {
    
    // Variables
    static let defaultColor = UIColor(red: 179.0/255.0, green: 189.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    static let defaultTintColor = UIColor(red: 0.0/255.0, green: 180.0/255.0, blue: 124.0/255.0, alpha: 1.0)
    private var annularLayers = [AnnularLayer]()
    private var horizontalLineLayers = [LineLayer]()
    private let containerLayer = CALayer()
    
    // MARK: - Properties
//    override public var frame: CGRect {
//        didSet{
//            self.updateSubLayers()
//        }
//    }
    
    @IBInspectable public var numberOfSteps: Int = 5 {
        didSet {
            self.createSteps()
        }
    }
    
    @IBInspectable public var currentStep: Int = -1 {
        didSet{
            if self.annularLayers.count <= 0 {
                return
            }
            if oldValue != self.currentStep {
                self.setCurrentStep(step: self.currentStep)
            }
        }
    }
    
    @IBInspectable public var displayNumbers: Bool = false {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleRadius:CGFloat = 10.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleColor:UIColor = defaultColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleTintColor:UIColor = defaultTintColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var circleStrokeWidth:CGFloat = 3.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineColor:UIColor = defaultColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineTintColor:UIColor = defaultTintColor {
        didSet {
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineMargin:CGFloat = 4.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable public var lineStrokeWidth:CGFloat = 2.0 {
        didSet{
            self.updateSubLayers()
        }
    }
    
    public var direction:StepIndicatorViewDirection = .leftToRight {
        didSet{
            self.updateSubLayers()
        }
    }
    
    @IBInspectable var directionRaw: UInt {
        get{
            return self.direction.rawValue
        }
        set{
            let value = newValue > 3 ? 0 : newValue
            self.direction = StepIndicatorViewDirection(rawValue: value)!
        }
    }
    
    
    // MARK: - Functions
    private func createSteps() {
        if let layers = self.layer.sublayers {
            for layer in layers {
                layer.removeFromSuperlayer()
            }
        }
        self.annularLayers.removeAll()
        self.horizontalLineLayers.removeAll()
        
        if self.numberOfSteps <= 0 {
            return
        }
        
        for i in 0..<self.numberOfSteps {
            let annularLayer = AnnularLayer()
            self.containerLayer.addSublayer(annularLayer)
            self.annularLayers.append(annularLayer)
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = LineLayer()
                self.containerLayer.addSublayer(lineLayer)
                self.horizontalLineLayers.append(lineLayer)
            }
        }
        
        self.layer.addSublayer(self.containerLayer)
        
        self.updateSubLayers()
        self.setCurrentStep(step: self.currentStep)
    }
    
    private func updateSubLayers() {
        self.containerLayer.frame = self.layer.bounds
        
        if self.direction == .leftToRight || self.direction == .rightToLeft {
            self.layoutHorizontal()
        }
        else{
            self.layoutVertical()
        }
        
        self.applyDirection()
    }
    
    private func layoutHorizontal() {
        let diameter = self.circleRadius * 2
        let stepWidth = self.numberOfSteps == 1 ? 0 : (self.containerLayer.frame.width - self.lineMargin * 2 - diameter) / CGFloat(self.numberOfSteps - 1)
        let y = self.containerLayer.frame.height / 2.0
        
        for i in 0..<self.annularLayers.count {
            let annularLayer = self.annularLayers[i]
            let x = self.numberOfSteps == 1 ? self.containerLayer.frame.width / 2.0 - self.circleRadius : self.lineMargin + CGFloat(i) * stepWidth
            annularLayer.frame = CGRect(x: x, y: y - self.circleRadius, width: diameter, height: diameter)
            self.applyAnnularStyle(annularLayer: annularLayer)
            annularLayer.step = i + 1
            annularLayer.updateStatus()
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = self.horizontalLineLayers[i]
                lineLayer.frame = CGRect(x: CGFloat(i) * stepWidth + diameter + self.lineMargin * 2, y: y - 1, width: stepWidth - diameter - self.lineMargin * 2, height: 3)
                self.applyLineStyle(lineLayer: lineLayer)
                lineLayer.updateStatus()
            }
        }
    }
    
    private func layoutVertical() {
        let diameter = self.circleRadius * 2
        let stepWidth = self.numberOfSteps == 1 ? 0 : (self.containerLayer.frame.height - self.lineMargin * 2 - diameter) / CGFloat(self.numberOfSteps - 1)
        let x = self.containerLayer.frame.width / 2.0
        
        for i in 0..<self.annularLayers.count {
            let annularLayer = self.annularLayers[i]
            let y = self.numberOfSteps == 1 ? self.containerLayer.frame.height / 2.0 - self.circleRadius : self.lineMargin + CGFloat(i) * stepWidth
            annularLayer.frame = CGRect(x: x - self.circleRadius, y: y, width: diameter, height: diameter)
            self.applyAnnularStyle(annularLayer: annularLayer)
            annularLayer.step = i + 1
            annularLayer.updateStatus()
            
            if (i < self.numberOfSteps - 1) {
                let lineLayer = self.horizontalLineLayers[i]
                lineLayer.frame = CGRect(x: x - 1, y: CGFloat(i) * stepWidth + diameter + self.lineMargin * 2, width: 3 , height: stepWidth - diameter - self.lineMargin * 2)
                lineLayer.isHorizontal = false
                self.applyLineStyle(lineLayer: lineLayer)
                lineLayer.updateStatus()
            }
        }
    }
    
    private func applyAnnularStyle(annularLayer:AnnularLayer) {
        annularLayer.annularDefaultColor = self.circleColor
        annularLayer.tintColor = self.circleTintColor
        annularLayer.lineWidth = self.circleStrokeWidth
        annularLayer.displayNumber = self.displayNumbers
    }
    
    private func applyLineStyle(lineLayer:LineLayer) {
        lineLayer.strokeColor = self.lineColor.cgColor
        lineLayer.tintColor = self.lineTintColor
        lineLayer.lineWidth = self.lineStrokeWidth
    }
    
    private func applyDirection() {
        switch self.direction {
        case .rightToLeft:
            let rotation180 = CATransform3DMakeRotation(CGFloat.pi, 0.0, 1.0, 0.0)
            self.containerLayer.transform = rotation180
            for annularLayer in self.annularLayers {
                annularLayer.transform = rotation180
            }
        case .bottomToTop:
            let rotation180 = CATransform3DMakeRotation(CGFloat.pi, 1.0, 0.0, 0.0)
            self.containerLayer.transform = rotation180
            for annularLayer in self.annularLayers {
                annularLayer.transform = rotation180
            }
        default:
            self.containerLayer.transform = CATransform3DIdentity
            for annularLayer in self.annularLayers {
                annularLayer.transform = CATransform3DIdentity
            }
        }
    }
    
    private func setCurrentStep(step:Int) {
        for i in 0..<self.numberOfSteps {
            if i < step {
                if !self.annularLayers[i].isFinished {
                    self.annularLayers[i].isFinished = true
                }
                
                self.setLineFinished(isFinished: true, index: i - 1)
            }
            else if i == step {
                self.annularLayers[i].isFinished = false
                self.annularLayers[i].isCurrent = true
                
                self.setLineFinished(isFinished: true, index: i - 1)
            }
            else{
                self.annularLayers[i].isFinished = false
                self.annularLayers[i].isCurrent = false
                
                self.setLineFinished(isFinished: false, index: i - 1)
            }
        }
    }
    
    private func setLineFinished(isFinished:Bool,index:Int) {
        if index >= 0 {
            if self.horizontalLineLayers[index].isFinished != isFinished {
                self.horizontalLineLayers[index].isFinished = isFinished
            }
        }
    }
}

class LineLayer: CAShapeLayer {
    
    private let tintLineLayer = CAShapeLayer()
    
    // MARK: - Properties
    var tintColor:UIColor?
    var isFinished:Bool = false {
        didSet{
            self.updateStatus()
        }
    }
    
    var isHorizontal:Bool = true {
        didSet{
            self.updateStatus()
        }
    }
    
    //MARK: - Initialization
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // MARK: - Functions
    func updateStatus() {
        self.drawLinePath()
        if isFinished {
            self.drawTintLineAnimated()
        }
        else{
            tintLineLayer.removeFromSuperlayer()
        }
    }
    
    private func drawLinePath() {
        let linePath = UIBezierPath()
        
        if self.isHorizontal {
            let centerY = self.frame.height / 2.0
            linePath.move(to: CGPoint(x: 0, y: centerY))
            linePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        }
        else{
            let centerX = self.frame.width / 2.0
            linePath.move(to: CGPoint(x: centerX, y: 0))
            linePath.addLine(to: CGPoint(x:centerX , y: self.frame.height))
        }
        
        self.path = linePath.cgPath
    }
    
    private func drawTintLineAnimated() {
        let tintLinePath = UIBezierPath()
        
        if self.isHorizontal {
            let centerY = self.frame.height / 2.0
            tintLinePath.move(to: CGPoint(x: 0, y: centerY))
            tintLinePath.addLine(to: CGPoint(x: self.frame.width, y: centerY))
        }
        else{
            let centerX = self.frame.width / 2.0
            tintLinePath.move(to: CGPoint(x: centerX, y: 0))
            tintLinePath.addLine(to: CGPoint(x: centerX, y: self.frame.height))
        }
        
        self.tintLineLayer.path = tintLinePath.cgPath
        self.tintLineLayer.frame = self.bounds
        self.tintLineLayer.strokeColor = self.tintColor?.cgColor
        self.tintLineLayer.lineWidth = self.lineWidth
        
        self.addSublayer(self.tintLineLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        self.tintLineLayer.add(animation, forKey: "animationDrawLine")
    }
}

class AnnularLayer: CAShapeLayer {
    
    private let fullCircleLayer = CAShapeLayer()
    private let centerCircleLayer = CAShapeLayer()
    private let flagLayer = CALayer()
    private let annularPath = UIBezierPath()
    lazy private var centerTextLayer = CATextLayer()
    
    static private let originalScale = CATransform3DMakeScale(1.0, 1.0, 1.0)
    static private let flagImageName = "CYStepIndicator_ic_done_white"
    static private var flagCGImage:CGImage?
    
    
    // MARK: - Properties
    var tintColor:UIColor?
    var displayNumber = false
    var step:Int = 0
    var annularDefaultColor: UIColor?
    
    var isCurrent:Bool = false {
        didSet{
            self.updateStatus()
        }
    }
    
    var isFinished:Bool = false {
        didSet{
            self.updateStatus()
        }
    }
    
    
    //MARK: - Initialization
    override init() {
        super.init()
        
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 3
        
        if AnnularLayer.flagCGImage == nil {
            var flagImage = UIImage(named: AnnularLayer.flagImageName)
            
            //For Pods bundle
            if flagImage == nil {
                let bundle = Bundle(for: AnnularLayer.self)
                if let url = bundle.url(forResource: "StepIndicator", withExtension: "bundle") {
                    let bundle = Bundle(url: url)
                    flagImage = UIImage(named: AnnularLayer.flagImageName, in: bundle, compatibleWith: nil)
                }
            }
            AnnularLayer.flagCGImage = flagImage?.cgImage
        }
        
        self.flagLayer.contents = AnnularLayer.flagCGImage
        self.fullCircleLayer.addSublayer(self.flagLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    // MARK: - Functions
    func updateStatus() {
        if isFinished {
            self.path = nil
            self.drawFullCircleAnimated()
        }
        else{
            fullCircleLayer.removeFromSuperlayer()
            
            self.drawAnnularPath()
            
            if self.displayNumber {
                self.centerCircleLayer.removeFromSuperlayer()
                
                if isCurrent {
                    self.strokeColor = self.tintColor?.cgColor
                }
                else{
                    self.strokeColor = self.annularDefaultColor?.cgColor
                }
                
                self.drawText()
            }
            else{
                self.centerTextLayer.removeFromSuperlayer()
                self.strokeColor = self.annularDefaultColor?.cgColor
                
                if isCurrent {
                    self.drawCenterCircleAnimated()
                }
                else{
                    self.centerCircleLayer.removeFromSuperlayer()
                }
            }
        }
    }
    
    private func drawAnnularPath() {
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0 - self.lineWidth / 2.0
        
        self.annularPath.removeAllPoints()
        self.annularPath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.path = self.annularPath.cgPath
    }
    
    private func drawCenterCircleAnimated() {
        let centerPath = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0 - self.lineWidth - sideLength * 0.15
        
        centerPath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.centerCircleLayer.path = centerPath.cgPath
        self.centerCircleLayer.transform = AnnularLayer.originalScale
        self.centerCircleLayer.frame = self.bounds
        self.centerCircleLayer.anchorPoint = CGPoint(x:0.5,y:0.5)
        self.centerCircleLayer.fillColor = self.tintColor?.cgColor
        self.addSublayer(self.centerCircleLayer)
        
        self.centerTextLayer.removeFromSuperlayer()
        
        self.animateCenter()
        self.strokeColor = self.annularDefaultColor?.cgColor
    }
    
    private func drawText() {
        let sideLength = fmin(self.frame.width, self.frame.height)
        
        self.centerTextLayer.string = "\(self.step)"
        self.centerTextLayer.frame = self.bounds
        self.centerTextLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY * 1.2)
        self.centerTextLayer.contentsScale = UIScreen.main.scale
        self.centerTextLayer.foregroundColor = self.strokeColor
        self.centerTextLayer.alignmentMode = CATextLayerAlignmentMode.center
        let fontSize = sideLength * 0.65
        self.centerTextLayer.font = UIFont.boldSystemFont(ofSize: fontSize) as CFTypeRef
        self.centerTextLayer.fontSize = fontSize
        
        self.addSublayer(self.centerTextLayer)
    }
    
    private func animateCenter() {
        self.centerCircleLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            CATransaction.setCompletionBlock {
                self.centerCircleLayer.transform = AnnularLayer.originalScale
                self.centerCircleLayer.removeAllAnimations()
            }
            self.centerCircleLayer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0)
            self.centerCircleLayer.removeAllAnimations()
            self.centerCircleLayer.add(self.createTransformAnimationWithScale(x: 1.0, y: 1.0), forKey: "CenterLayerAnimationScale1.0")
        }
        self.centerCircleLayer.add(self.createTransformAnimationWithScale(x: 1.1, y: 1.1), forKey: "CenterLayerAnimationScale1.1")
        CATransaction.commit()
    }
    
    private func createTransformAnimationWithScale(x:CGFloat,y:CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.keyPath = "transform"
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.toValue = CATransform3DMakeScale(x, y, 1)
        return animation
    }
    
    private func drawFullCircleAnimated() {
        let fullCirclePath = UIBezierPath()
        let sideLength = fmin(self.frame.width, self.frame.height)
        let circlesRadius = sideLength / 2.0
        
        fullCirclePath.addArc(withCenter: CGPoint(x:self.bounds.midX, y:self.bounds.midY), radius: circlesRadius, startAngle: 0.0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        self.fullCircleLayer.path = fullCirclePath.cgPath
        self.fullCircleLayer.transform = AnnularLayer.originalScale
        self.fullCircleLayer.frame = self.bounds
        self.fullCircleLayer.fillColor = self.tintColor?.cgColor
        self.addSublayer(self.fullCircleLayer)
        
        let flagLayerWidth = self.fullCircleLayer.bounds.width * 0.8
        let flagLayerHeight = self.fullCircleLayer.bounds.height * 0.8
        self.flagLayer.frame = CGRect(x: self.fullCircleLayer.bounds.width * 0.2 / 2.0, y: self.fullCircleLayer.bounds.height * 0.2 / 2.0, width:flagLayerWidth, height:flagLayerHeight)
        
        self.animateFullCircle()
    }
    
    private func animateFullCircle() {
        self.fullCircleLayer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
        self.fullCircleLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.fullCircleLayer.transform = AnnularLayer.originalScale
        }
        self.fullCircleLayer.add(self.createTransformAnimationWithScale(x: 1.0, y: 1.0), forKey: "FullCircleAnimationScale1.0")
        CATransaction.commit()
    }
    
}
