//
//  AddReminderMemoTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import SnapKit

class AddReminderMemoTableViewCell: BaseTableViewCell {

    let textView = UITextView()
    
    override func configureHierarchy() {
        contentView.addSubview(textView)
    }
    
    override func configureLayout() {
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
            
        }
    }
    //TODO: 플레이스홀더
    override func configureView() {
        textView.textColor = .white
        textView.backgroundColor = .clear
        backgroundColor = .systemGray5
    }
}
