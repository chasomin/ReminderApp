//
//  TagViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

class TagViewController: BaseViewController {

    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("TagMessage"), object: nil, userInfo: ["tag":textField.text!])
    }
    override func configureHierarchy() {
        view.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        textField.backgroundColor = .systemGray6
        textField.textColor = .white
        textField.placeholder = "한 줄 메모"
    }
    
}
