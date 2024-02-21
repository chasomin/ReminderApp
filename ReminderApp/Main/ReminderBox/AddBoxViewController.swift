//
//  AddBoxViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import RealmSwift
final class AddBoxViewController: UIViewController {
    
    let mainView = AddBoxView()

    let repository = ReminderModelRepository()
    let boxData = ReminderBox(title: "", regDate: Date(), color: 5, icon: 5)
    var delegate: ReloadDelegate?

    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "새로운 목록"
        
        setNavigationLeftBarButton(title: "취소", image: nil, action: #selector(leftBarButtonTapped))
        setNavigationRightBarButton(title: "완료", image: nil, action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        mainView.titleView.textField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(boxColorReceivedNotification), name: NSNotification.Name("Color"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(boxIconReceivedNotification), name: NSNotification.Name("Icon"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.reload()
    }
 
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        repository.createItem(boxData, type: ReminderBox.self)
        dismiss(animated: true)
    }
    
    @objc func boxColorReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["color"] as? Int {
            self.boxData.color = value
        }
    }
    
    @objc func boxIconReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["icon"] as? Int {
            self.boxData.icon = value
        }
    }
}

extension AddBoxViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text != "" {
            navigationItem.rightBarButtonItem?.isEnabled = true
            boxData.title = textField.text!
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }

        print(boxData)

    }
    
    
}


