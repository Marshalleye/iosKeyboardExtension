//
//  KeyboardViewController.swift
//  tune-extension
//
//  Created by Nazar Kapushchak on 3/18/24.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "I'm a label"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayLabel)
        
        // Set up the label constraints
        NSLayoutConstraint.activate([
            displayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            displayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            displayLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            displayLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    @objc func didTapButton() {
        // Insert text at the current cursor position
//        let proxy = self.textDocumentProxy
//        proxy.insertText("Hello, World!")
        
        // You can use methods like `deleteBackward` to delete text and `setMarkedText` to set partially-completed text from an IME (input method editor).
        // For example, to delete a single character before the cursor:
        // proxy.deleteBackward()
    }
    
    override func viewWillLayoutSubviews() {
        //        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        let textBeforeCursor = self.textDocumentProxy.documentContextBeforeInput ?? ""
        let textAfterCursor = self.textDocumentProxy.documentContextAfterInput ?? ""
        displayLabel.text = textBeforeCursor + textAfterCursor
    }
    
}
