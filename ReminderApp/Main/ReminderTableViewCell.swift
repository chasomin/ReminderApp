//
//  ReminderTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class ReminderTableViewCell: BaseTableViewCell {
    let icon = CircleImageView(frame: .zero)
    let title = UILabel()
    let count = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(count)
    }
    
    override func configureLayout() {
        icon.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(15)
            make.width.equalTo(icon.snp.height)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview().inset(15)
        }
        count.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            make.width.equalTo(20)
        }
    }
    
    override func configureView() {    
        
        icon.image.contentMode = .scaleAspectFit
        
        title.font = .systemFont(ofSize: 13)
        title.textColor = .white
        title.textAlignment = .left
        title.numberOfLines = 1
        
        count.font = .systemFont(ofSize: 13)
        count.textColor = .systemGray
        
        count.textAlignment = .right
        count.numberOfLines = 1
        
        
        accessoryType = .disclosureIndicator
        backgroundColor = .systemGray6
    }

    func configureCell(data: ReminderBox) {
        title.text = data.title
        count.text = "\(data.reminder.count)"
        
        icon.backgroundColor = BoxColor.allCases[data.color].color
        icon.image.image = BoxIcon.allCases[data.icon].icon
    }
}
