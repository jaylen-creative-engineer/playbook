//
//  PhotoViewController.swift
//  pursue
//
//  Created by Jaylen Sanders on 2/20/18.
//  Copyright © 2018 Glory. All rights reserved.
//

import UIKit
import Photos
import XLActionController
import Hero
import SnapSliderFilters

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        updateStillImage()
    }
    
    private var backgroundImage: UIImage
    var asset: PHAsset!
    fileprivate var data:[SNFilter] = []
    
    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: backgroundImageView.bounds.width * scale,
                      height: backgroundImageView.bounds.height * scale)
    }
    
    lazy var progressView : UIProgressView = {
        let pv = UIProgressView()
        return pv
    }()
    
    init(image: UIImage) {
        self.backgroundImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var backgroundImageView : UIImageView = {
       let iv = UIImageView()
        iv.image = backgroundImage
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 4
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "cancel").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    lazy var continueButton : UIButton = {
       let cv = UIButton()
        cv.backgroundColor = .black
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.cornerRadius = 20
        cv.layer.masksToBounds = true
        cv.addTarget(self, action: #selector(handlePursuit), for: .touchUpInside)
        return cv
    }()
    
    lazy var forwardArrow : UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "forward-arrow").withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePursuit))
        tap.numberOfTapsRequired = 1
        iv.addGestureRecognizer(tap)
        return iv
    }()
    
    lazy var highlightIcon : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "mark").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHighlight), for: .touchUpInside)
        return button
    }()
    
    lazy var highlightLabel : UILabel = {
        let label = UILabel()
        label.text = "Mark"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleHighlight))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var saveIcon : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "save").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var saveLabel  : UILabel = {
        let label = UILabel()
        label.text = "Save"
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSave))
        tap.numberOfTapsRequired = 1
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var saveBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    lazy var soundButton : UIButton = {
       let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "sound").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    

    lazy var keyboardButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "keyboard").withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(setupEditTextField), for: .touchUpInside)
        return button
    }()
    
    lazy var highlightBackground : UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleHighlight), for: .touchUpInside)
        return button
    }()
    
    lazy var pursuitTitle : UITextView = {
        let tv = UITextView()
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.boldSystemFont(ofSize: 14)
        tv.isScrollEnabled = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 5
        
        let textStyling = [NSAttributedStringKey.paragraphStyle: paragraphStyle]
        let attrString = NSAttributedString(string: "", attributes: textStyling)
        tv.attributedText = attrString
        return tv
    }()
    
    lazy var pursuitUnderline : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handlePursuit(){
        let customAlert = CustomAlertView()
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(customAlert, animated: true, completion: nil)
    }
    
    @objc func handleSave(){
        UIImageWriteToSavedPhotosAlbum(backgroundImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func handleHighlight () {
        let actionController = SkypeActionController()
  
        actionController.addAction(Action("Mark as principle", style: .default, handler: { action in
            // do something useful
        }))
        actionController.addAction(Action("Mark as step", style: .default, handler: { action in
            // do something useful
        }))
        
        actionController.addAction(Action("Cancel", style: .default, handler: {action in
            
        }))
        present(actionController, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStillImage() {
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        PHImageManager.default().requestImage(for: asset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler: { image, _ in

            guard let image = image else { return }
            
            self.backgroundImageView.isHidden = false
            self.backgroundImageView.image = image
        })
    }
    
    func setupBottomLeftOptions(){
        view.addSubview(highlightLabel)
        view.addSubview(highlightIcon)
        view.addSubview(saveLabel)
        view.addSubview(saveIcon)
        view.addSubview(highlightBackground)
        view.addSubview(saveBackground)
        
        highlightLabel.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: continueButton.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: highlightLabel.intrinsicContentSize.width, height: highlightLabel.intrinsicContentSize.height)
        highlightIcon.anchor(top: nil, left: nil, bottom: highlightLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 22, height: 20)
        highlightIcon.centerXAnchor.constraint(equalTo: highlightLabel.centerXAnchor).isActive = true
        highlightBackground.anchor(top: highlightIcon.topAnchor, left: highlightLabel.leftAnchor, bottom: highlightLabel.bottomAnchor, right: highlightLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        saveLabel.anchor(top: highlightLabel.topAnchor, left: highlightLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0, width: saveLabel.intrinsicContentSize.width, height: saveLabel.intrinsicContentSize.height)
        saveIcon.anchor(top: nil, left: nil, bottom: saveLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 20, height: 20)
        saveIcon.centerXAnchor.constraint(equalTo: saveLabel.centerXAnchor).isActive = true
        saveBackground.anchor(top: saveIcon.topAnchor, left: saveLabel.leftAnchor, bottom: saveLabel.bottomAnchor, right: saveLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    func setupTopOptions() {
        view.addSubview(cancelButton)
        view.addSubview(keyboardButton)
        
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 18, paddingBottom: 0, paddingRight: 0, width: 15, height: 15)
        keyboardButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 18, width: 22, height: 17)
    }
 
    func setupView(){
        setupTopOptions()
        
        view.addSubview(backgroundImageView)
        view.addSubview(pursuitTitle)
        view.addSubview(pursuitUnderline)
        view.addSubview(continueButton)
        view.addSubview(forwardArrow)
       
        backgroundImageView.anchor(top: cancelButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 52, paddingLeft: 42, paddingBottom: 0, paddingRight: 42, width: 0, height: view.frame.height / 2)
        pursuitTitle.anchor(top: backgroundImageView.bottomAnchor, left: backgroundImageView.leftAnchor, bottom: nil, right: backgroundImageView.rightAnchor, paddingTop: 18, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: pursuitTitle.intrinsicContentSize.height)
        pursuitUnderline.anchor(top: pursuitTitle.bottomAnchor, left: pursuitTitle.leftAnchor, bottom: nil, right: pursuitTitle.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        continueButton.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 24, width: 40, height: 40)
        forwardArrow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 15, height: 10)
        forwardArrow.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor).isActive = true
        forwardArrow.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor).isActive = true
        
        setupBottomLeftOptions()
    }
    
    @objc func setupEditTextField(){
        let textfield = SNTextField(x: backgroundImageView.frame.minX, y: SNUtils.screenSize.height / 2, width: backgroundImageView.frame.width, heightOfScreen: SNUtils.screenSize.height)
        textfield.layer.zPosition = 100
        textfield.backgroundColor = .lightGray
        view.addSubview(textfield)
        self.textFieldCheck = textfield
        textfield.handleTap()
        NotificationCenter.default.addObserver(textfield, selector: #selector(SNTextField.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(textfield, selector: #selector(SNTextField.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(textfield, selector: #selector(SNTextField.keyboardTypeChanged(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    var isLeaving = false
    var textFieldCheck : SNTextField?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isLeaving = true
        if textFieldCheck != nil {
            NotificationCenter.default.removeObserver(textFieldCheck!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.isHeroEnabled = true
        
        pursuitTitle.selectedTextRange = pursuitTitle.textRange(from: pursuitTitle.beginningOfDocument, to: pursuitTitle.beginningOfDocument)
        setupView()
    }
    
    @objc func cancel() {
        navigationController?.isHeroEnabled = true
        navigationController?.heroNavigationAnimationType = .fade
        dismiss(animated: true, completion: nil)
    }
}

extension PhotoViewController : UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {
            
            textView.text = "Add Caption"
            textView.textColor = .gray
            textView.font = UIFont.boldSystemFont(ofSize: 14)
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }

}

extension PhotoViewController : SNSliderDataSource {
    
    func numberOfSlides(_ slider: SNSlider) -> Int {
        return data.count
    }
    
    func slider(_ slider: SNSlider, slideAtIndex index: Int) -> SNFilter {
        return data[index]
    }
    
    func startAtIndex(_ slider: SNSlider) -> Int {
        return 0
    }
}

