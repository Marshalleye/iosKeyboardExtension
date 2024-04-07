//
//  KeyboardViewController.swift
//  tune-extension
//
//  Created by Nazar Kapushchak on 3/18/24.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    let resultTextField: UILabel = {
        let label = UILabel()
        label.text = "Type here"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 45/255, green: 52/255, blue: 80/255, alpha: 1.0)
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 145/255, green: 154/255, blue: 170/255, alpha: 1.0)
        label.text = "Result:"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let topZoneScrollView = UIScrollView()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupKeyboardLayout()
    }
    
    func setupScrollView() {
        let labelHolderView = UIView()
        
        let appFeatureTitles: [String] = [
            "Spell Check",
            "Pharaphrase",
            "Versify",
            "Emojify",
            "Grammar Check"
        ]
        
        topZoneScrollView.addSubview(labelHolderView)
        
        // add the scroll view to the view
        view.addSubview(topZoneScrollView)
        
        // all three need this
        labelHolderView.translatesAutoresizingMaskIntoConstraints = false
        topZoneScrollView.translatesAutoresizingMaskIntoConstraints = false
        topZoneScrollView.showsVerticalScrollIndicator = false
        topZoneScrollView.showsHorizontalScrollIndicator = false
        
        let safeG = view.safeAreaLayoutGuide
        let contentG = topZoneScrollView.contentLayoutGuide
        let frameG = topZoneScrollView.frameLayoutGuide
        
        // let's use some background colors so we can see the view frames
        topZoneScrollView.backgroundColor = .clear
        labelHolderView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            topZoneScrollView.topAnchor.constraint(equalTo: safeG.topAnchor, constant: 0.0),
            topZoneScrollView.leadingAnchor.constraint(equalTo: safeG.leadingAnchor, constant: 0.0),
            topZoneScrollView.trailingAnchor.constraint(equalTo: safeG.trailingAnchor, constant: 0.0),
            topZoneScrollView.heightAnchor.constraint(equalToConstant: 50.0),
            
            // constrain holder view to ContentGuide with Zero on all 4 sides
            labelHolderView.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 0.0),
            labelHolderView.leadingAnchor.constraint(equalTo: contentG.leadingAnchor, constant: 0.0),
            labelHolderView.trailingAnchor.constraint(equalTo: contentG.trailingAnchor, constant: 0.0),
            labelHolderView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: 0.0),
            
            // we only want horizontal scrolling, so constrain
            //  holder view height to sccroll view FrameGuide
            labelHolderView.heightAnchor.constraint(equalTo: frameG.heightAnchor),
            
            // we want the label centered horizontally
            //  in the holder view and in the scroll view
            //  so set holder view width >= FrameGuide
            labelHolderView.widthAnchor.constraint(greaterThanOrEqualTo: frameG.widthAnchor, constant: 0.0)
        ])
        
        // add a button above the scroll view to cycle through our sample strings
        var previousButton: UIButton?
        var btnIndex = 0
        for featureTitle in appFeatureTitles {
            let UIBtn = UIButton(type: .system)
            btnIndex += 1
            UIBtn.setTitle(featureTitle, for: .normal)
            UIBtn.setTitleColor(.white, for: .normal)
            UIBtn.setTitleColor(.lightGray, for: .highlighted)
            UIBtn.backgroundColor = UIColor(red: 111/255, green: 118/255, blue: 150/255, alpha: 1.0)
            UIBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            UIBtn.layer.cornerRadius = 10
            UIBtn.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            labelHolderView.addSubview(UIBtn)
            
            UIBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                UIBtn.heightAnchor.constraint(equalToConstant:40),
                UIBtn.widthAnchor.constraint(equalToConstant: 100),
                UIBtn.centerYAnchor.constraint(equalTo: contentG.centerYAnchor),
                UIBtn.leadingAnchor.constraint(equalTo: previousButton?.trailingAnchor ?? labelHolderView.leadingAnchor, constant: 5),
                UIBtn.trailingAnchor.constraint(lessThanOrEqualTo: labelHolderView.trailingAnchor, constant: -8.0),
            ])
            
            previousButton = UIBtn
        }
        
    }
    
    func setupKeyboardLayout() {
        let keyboardView = UIView(frame: CGRect(x: 0, y: 50, width: view.frame.width , height: 200))
        keyboardView.backgroundColor = UIColor(red: 220/255, green: 227/255, blue: 233/255, alpha: 1.0)
        
        view.addSubview(keyboardView)
        
        // Middle Zone
        let middleZone = UIView();
        //        middleZone.backgroundColor = UIColor(red: 220/255, green: 227/255, blue: 233/255, alpha: 1.0)
        
        middleZone.backgroundColor = .clear
        middleZone.addSubview(resultLabel)
        
        middleZone.addSubview(resultTextField)
        
        middleZone.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultTextField.translatesAutoresizingMaskIntoConstraints = false
        
        keyboardView.addSubview(middleZone)
        
        NSLayoutConstraint.activate([
            middleZone.topAnchor.constraint(equalTo: keyboardView.topAnchor),
            middleZone.leftAnchor.constraint(equalTo: keyboardView.leftAnchor),
            middleZone.rightAnchor.constraint(equalTo: keyboardView.rightAnchor),
            middleZone.heightAnchor.constraint(lessThanOrEqualTo: keyboardView.heightAnchor, constant: 100),
            
            resultLabel.topAnchor.constraint(equalTo: middleZone.topAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: middleZone.leadingAnchor, constant: 20),
            
            resultTextField.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            resultTextField.leadingAnchor.constraint(equalTo: middleZone.leadingAnchor, constant: 20)
        ])
        
        //    Bottom Zone
        let bottomZone = UIView()
        //        bottomZone.backgroundColor = UIColor(red: 220/255, green: 227/255, blue: 233/255, alpha: 1.0)
        bottomZone.backgroundColor = .clear
        
        let trashButton = createIconButton(systemName: "trash.circle.fill")
        let applyButton = createButton(title: "Apply")
        let arrowButton = createIconButton(systemName: "arrow.2.circlepath.circle.fill")
        
        bottomZone.addSubview(trashButton)
        bottomZone.addSubview(applyButton)
        bottomZone.addSubview(arrowButton)
        keyboardView.addSubview(bottomZone)
        
        bottomZone.translatesAutoresizingMaskIntoConstraints = false
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //            bottomZone.topAnchor.constraint(equalTo: middleZone.bottomAnchor),
            bottomZone.leadingAnchor.constraint(equalTo: middleZone.leadingAnchor),
            bottomZone.trailingAnchor.constraint(equalTo: middleZone.trailingAnchor),
            bottomZone.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1),
            bottomZone.leftAnchor.constraint(equalTo: keyboardView.leftAnchor),
            bottomZone.rightAnchor.constraint(equalTo: keyboardView.rightAnchor),
            bottomZone.heightAnchor.constraint(equalTo: middleZone.heightAnchor, constant: 70),
            
            trashButton.centerYAnchor.constraint(equalTo: bottomZone.centerYAnchor),
            applyButton.centerYAnchor.constraint(equalTo: bottomZone.centerYAnchor),
            arrowButton.centerYAnchor.constraint(equalTo: bottomZone.centerYAnchor),
            
            
            trashButton.heightAnchor.constraint(equalToConstant:40),
            trashButton.widthAnchor.constraint(equalToConstant: 40),
            arrowButton.heightAnchor.constraint(equalToConstant:40),
            arrowButton.widthAnchor.constraint(equalToConstant: 40),
            applyButton.heightAnchor.constraint(equalToConstant:40),
            applyButton.widthAnchor.constraint(equalToConstant: 120),
            
            trashButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -130),
            applyButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            arrowButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 130)
        ])
    }
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        // Handle button press event
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.frame = CGRectMake(0, 0, 100, 50)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 44/255, green: 51/255, blue: 80/255, alpha: 1.0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }
    
    func createIconButton(systemName: String) -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: systemName)
        button.setImage(image, for: .normal)
        button.frame = CGRectMake(0, 0, 20, 50)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 44/255, green: 51/255, blue: 80/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func didTapButton() {
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        let textBeforeCursor = self.textDocumentProxy.documentContextBeforeInput ?? resultTextField.text
        let textAfterCursor = self.textDocumentProxy.documentContextAfterInput ?? ""
        resultTextField.text = textBeforeCursor! + textAfterCursor
    }
    
}
