import SwiftUI

// copy from https://github.com/0Itsuki0/SwiftCustomKeyboard/blob/main/HelloKeyboardDemo/AppSpecificKeyboardDemo.swift
//class AIKeyboardView: UIInputViewController{
//    override func viewDidLoad() {
//            super.viewDidLoad()
//                    
//            let animalKeyboardViewController = UIHostingController(
//                rootView: AIKeyboardContentView(
//                    insert_text: { [weak self] text in
//                        guard let self else { return }
//                        self.textDocumentProxy.insertText(text)
//
//                    },
//                    delete_text: { [weak self] in
//                        guard let self,
//                              self.textDocumentProxy.hasText else { return }
//
//                        self.textDocumentProxy.deleteBackward()
//                    },
////                    needsInputModeSwitchKey: self.needsInputModeSwitchKey,
////    //                needsInputModeSwitchKey: true,
////                    nextKeyboardAction: #selector(self.handleInputModeList(from:with:)),
//                ))
//            
//            let animalKeyboardView = animalKeyboardViewController.view!
//            animalKeyboardView.translatesAutoresizingMaskIntoConstraints = false
//            
//            // default to white
//            animalKeyboardViewController.view.backgroundColor = .clear
//
//            
//            self.addChild(animalKeyboardViewController)
//            self.view.addSubview(animalKeyboardView)
//            animalKeyboardViewController.didMove(toParent: self)
//
//            NSLayoutConstraint.activate([
//                animalKeyboardView.leftAnchor.constraint(equalTo: view.leftAnchor),
//                animalKeyboardView.topAnchor.constraint(equalTo: view.topAnchor),
//                animalKeyboardView.rightAnchor.constraint(equalTo: view.rightAnchor),
//                animalKeyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//        }
//}
