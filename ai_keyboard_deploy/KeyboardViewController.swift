//
//  KeyboardViewController.swift
//  ai_keyboard_deploy
//
//  Created by Gena on 07.02.2026.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ai_keyboard_view_controller = UIHostingController(
            rootView: AIKeyboardContentView(insert_text: {
                (str : String ) in
                self.textDocumentProxy.insertText(str)
            },
                                            delete_text: self.textDocumentProxy.deleteBackward)
                .frame(height: 300)
        )
        
        let ai_keyboard_view = ai_keyboard_view_controller.view!
        ai_keyboard_view.translatesAutoresizingMaskIntoConstraints = false
                
        ai_keyboard_view.backgroundColor = .darkGray

                
        self.addChild(ai_keyboard_view_controller)
        self.view.addSubview(ai_keyboard_view)
        ai_keyboard_view_controller.didMove(toParent: self)

        NSLayoutConstraint.activate([
            ai_keyboard_view.leftAnchor.constraint(equalTo: view.leftAnchor),
            ai_keyboard_view.topAnchor.constraint(equalTo: view.topAnchor),
            ai_keyboard_view.rightAnchor.constraint(equalTo: view.rightAnchor),
            ai_keyboard_view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//class KeyboardViewController: UIInputViewController {

//    @IBOutlet var nextKeyboardButton: UIButton!
//    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//        
//        // Add custom view sizing constraints here
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//        
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//        
//        self.view.addSubview(self.nextKeyboardButton)
//        
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//    
//    override func viewWillLayoutSubviews() {
//        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
//        super.viewWillLayoutSubviews()
//    }
//    
//    override func textWillChange(_ textInput: UITextInput?) {
//        // The app is about to change the document's contents. Perform any preparation here.
//    }
//    
//    override func textDidChange(_ textInput: UITextInput?) {
//        // The app has just changed the document's contents, the document context has been updated.
//        
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
//    }

//}
