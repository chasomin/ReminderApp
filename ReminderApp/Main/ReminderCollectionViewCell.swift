//
//  ReminderListCollectionViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

final class ReminderCollectionViewCell: BaseCollectionViewCell {
    let iconImageView = CircleImageView(frame: .zero)
    let title = UILabel()
    let reminderCount = UILabel()
    
    
    override func configureHierarchy() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(title)
        contentView.addSubview(reminderCount)
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(10)
            make.width.height.equalTo(40)
        }
        
        reminderCount.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(10)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.leading.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    override func configureView() {
        title.font = .boldSystemFont(ofSize: 17)
        title.textColor = .lightGray
        
        reminderCount.font = .boldSystemFont(ofSize: 35)
        reminderCount.textColor = .white
        reminderCount.textAlignment = .right

        backgroundColor = .darkGray
        layer.cornerRadius = 15
    }
}

extension ReminderCollectionViewCell {
    func configureCell(index: Int, data: Results<ReminderModel>) {
        let value = ReminderList.allCases[index]
        
        iconImageView.image.image = value.image
        iconImageView.backgroundColor = value.color
        title.text = value.rawValue
        
        let count = ReminderList.allCases[index].getReminderCount(data: data)
        reminderCount.text = "\(count)"
    }
}
