//
//  DeadlineViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class DeadlineViewController: BaseViewController {

    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let format = DateFormatter()
    
    var date: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        date?(textField.text!)
        print(textField.text!)
    }
    
    override func configureHierarchy() {
        view.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        textField.placeholder = "마감일"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.inputView = datePicker
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
    }
    
    @objc func datePickerValueChanged() {
        format.dateFormat = "yy년 MM월 dd일"
        let result = format.string(from: datePicker.date)
        textField.text = "\(result)"
        print(datePicker.date)
    }
    
}

