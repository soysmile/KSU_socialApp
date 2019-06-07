//
//  ChatInputContainerView.swift
//  FirebaseApp
//
//  Created by George Heints on 11.04.2018.
//  Copyright © 2018 Robert Canton. All rights reserved.
//
import UIKit

extension UITextField {

    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil){
        if let left = left {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }

        if let right = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }

}

class ChatInputContainerView: UIView, UITextFieldDelegate, UITableViewDelegate {
    
    weak var chatLogController: ChatLogController? {
       didSet {

            sendButton.addTarget(chatLogController, action: #selector(ChatLogController.handleSend), for: .touchUpInside)
            uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: chatLogController, action: #selector(ChatLogController.handleUploadTap)))

        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(red: 24.0/255.0, green: 34.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        textField.layer.cornerRadius = 17.5
        textField.setPadding(left: 10, right: 5)
        //HERE
        //textField.attributedPlaceholder = NSAttributedString(string: "Enter message...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 62.0/255.0, green: 73.0/255.0, blue: 85.0/255.0, alpha: 1.0)])
        textField.delegate = self
        return textField
    }()
    
    let uploadImageView: UIImageView = {
        let uploadImageView = UIImageView()
        uploadImageView.isUserInteractionEnabled = true
        uploadImageView.image = UIImage(named: "upload_image_icon")
        uploadImageView.translatesAutoresizingMaskIntoConstraints = false
        return uploadImageView
    }()
    
    let sendButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 34.0/255.0, green: 48.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        addSubview(uploadImageView)
        //x,y,w,h
        uploadImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        uploadImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        uploadImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        


        sendButton.setTitle("Отправить", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        //what is handleSend?
        
        addSubview(sendButton)
        //x,y,w,h
        sendButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(self.inputTextField)
        //x,y,w,h
        self.inputTextField.leftAnchor.constraint(equalTo: uploadImageView.rightAnchor, constant: 8).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(red: 34.0/255.0, green: 48.0/255.0, blue: 63.0/255.0, alpha: 1.0)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separatorLineView)
        //x,y,w,h
        separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatLogController?.handleSend()
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
