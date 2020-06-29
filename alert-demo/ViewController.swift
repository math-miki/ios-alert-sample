//
//  ViewController.swift
//  alert-demo
//
//  Created by Miki Takahashi on 2020/06/29.
//  Copyright © 2020 MikiTakahashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let showAlertButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
//        showAlertButton.translatesAutoresizingMaskIntoConstraints = false
        showAlertButton.setTitle("show alert", for: .normal)
        showAlertButton.setTitleColor(UIColor.black, for: .normal)
        showAlertButton.layer.borderColor = UIColor.black.cgColor
        showAlertButton.layer.borderWidth = 4
        showAlertButton.layer.cornerRadius = 8
        showAlertButton.layer.backgroundColor = UIColor.gray.cgColor
        
        showAlertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
//        showAlertButton.layer.add
        self.view.addSubview(showAlertButton)
        
        let showActionSheetButton = UIButton()
        showActionSheetButton.translatesAutoresizingMaskIntoConstraints = false
        showActionSheetButton.setTitle("show actionsheet", for: .normal)
        showActionSheetButton.setTitleColor(UIColor.black, for: .normal)
        showActionSheetButton.layer.borderColor = UIColor.black.cgColor
        showActionSheetButton.layer.borderWidth = 4
        showActionSheetButton.layer.cornerRadius = 8
        showActionSheetButton.layer.backgroundColor = UIColor.gray.cgColor
        showActionSheetButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        self.view.addSubview(showActionSheetButton)
        
        showActionSheetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive.toggle()
        showActionSheetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive.toggle()
        showActionSheetButton.widthAnchor.constraint(equalToConstant: 240).isActive.toggle()
        showActionSheetButton.heightAnchor.constraint(equalToConstant: 60).isActive.toggle()
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
        alert.addTextField { (textFiled) in
            textFiled.placeholder = "username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
        }
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
            print("cancel")
        }
        let alertActionDefault = UIAlertAction(title: "OK", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            let textFileds = alert.textFields
            guard (textFileds?.count ?? 0)>=2 , let userNameField = textFileds?[0], let passwordField = textFileds?[1]  else {
                return
            }
            print("username: \(userNameField.text), password: \(passwordField.text)")
        })
        let alertActionDelete = UIAlertAction(title: "Delete", style: .destructive, handler: deleteAction(action:))
        alert.addAction(alertActionCancel)
        alert.addAction(alertActionDelete)
        alert.addAction(alertActionDefault)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteAction(action: UIAlertAction) {
        print("delete action")
    }
    
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: "LightUpCoffee", message: nil, preferredStyle: .actionSheet)
        let copyAction = UIAlertAction(title: "場所の名前をコピーする", style: .default, handler: nil)
        let searchAction = UIAlertAction(title: "Googleで検索する", style: .default) {
            (action) in
            let placeName = "Light Up Coffee"
            let urlString = "https://www.google.com/search?q=\(placeName)"
            let encodeUrlString: String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let url = URL(string: encodeUrlString)
            if url != nil, UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        actionSheet.addAction(copyAction)
        actionSheet.addAction(searchAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

