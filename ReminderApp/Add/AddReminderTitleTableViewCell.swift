//
//  AddReminderTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

final class AddReminderTitleTableViewCell: BaseTableViewCell {

    let textField = UITextField()
    
    override func configureHierarchy() {
        contentView.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        textField.placeholder = "   제목"
        textField.textColor = .white
        
        backgroundColor = .systemGray5
    }
    
    func configureCell(text: String, delegate: UITextFieldDelegate) {
        textField.delegate = delegate
        textField.text = text
    }
}
