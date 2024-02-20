//
//  AddBoxViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit

final class AddBoxViewController: UIViewController {
    
    let mainView = AddBoxView()

    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "새로운 목록"
        
        setNavigationLeftBarButton(title: "취소", image: nil, action: #selector(leftBarButtonTapped))
        setNavigationRightBarButton(title: "완료", image: nil, action: #selector(rightBarButtonTapped))
    }
    
    @objc func leftBarButtonTapped() {
        print(#function)
    }
    
    @objc func rightBarButtonTapped() {
        print(#function)

    }
}


