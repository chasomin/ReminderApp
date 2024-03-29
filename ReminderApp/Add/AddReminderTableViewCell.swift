//
//  AddReminderTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

class AddReminderTableViewCell: BaseTableViewCell {

    let textField = UITextField()
    
    override func configureHierarchy() {
        contentView.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            
        }
    }
    
    override func configureView() {
        textField.textColor = .white
        
        backgroundColor = .systemGray5
        
        self.selectionStyle = .none
        
    }
}
