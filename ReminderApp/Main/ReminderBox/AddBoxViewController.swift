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
    let realm = try! Realm()
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

        print(realm.configuration.fileURL)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.reload()
    }
 
    
    @objc func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        print(#function)
        //TODO: 저장, 타이틀 없으면 비활성화
        
        do {
            try realm.write {
                realm.add(boxData)
            }
        } catch {
            print(error)
        }
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


