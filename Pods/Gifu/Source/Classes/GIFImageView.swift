/// Example class that conforms to `GIFAnimatable`. Uses default values for the animator frame buffer count and resize behavior. You can either use it directly in your code or use it as a blueprint for your own subclass.
public class GIFImageView: UIImageView, GIFAnimatable {

  /// A lazy animator.
  public lazy var animator: Animator? = {
    return Animator(withDelegate: self)
  }()

  /// Layer delegate method called periodically by the layer. **Should not** be called manually.
  ///
  /// - parameter layer: The delegated layer.
  override public func display(_ layer: CALayer) {
    updateImageIfNeeded()
  }
}

extension GIFImageView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
