//
//  ReminderListTableViewCell.swift
//  ReminderApp
//
//  Created by 차소민 on 2/15/24.
//

import UIKit
import SnapKit

final class ReminderListTableViewCell: BaseTableViewCell {
    let isDoneButton = UIButton()
    let title = UILabel()
    let memo = UILabel()
    let tagLabel = UILabel()
    let deadline = UILabel()
    let priority = UILabel()
    private let repository = ReminderModelRepository()
    
    override func configureHierarchy() {
        contentView.addSubview(isDoneButton)
        contentView.addSubview(title)
        contentView.addSubview(memo)
        contentView.addSubview(tagLabel)
        contentView.addSubview(deadline)
        contentView.addSubview(priority)
    }

    override func configureLayout() {
        isDoneButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.width.equalTo(30)
        }
        title.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(priority.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        memo.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(title)
        }
        deadline.snp.makeConstraints { make in
            make.top.equalTo(memo.snp.bottom).offset(5)
            make.leading.equalTo(title)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(90)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(deadline)
            make.leading.equalTo(deadline.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        
        priority.snp.makeConstraints { make in
            make.leading.equalTo(isDoneButton.snp.trailing).offset(10)
            make.verticalEdges.equalTo(title)
        }
    }
    
    override func configureView() {
        isDoneButton.tintColor = .systemGray4
        
        backgroundColor = .black
        title.font = .boldSystemFont(ofSize: 17)
        title.textColor = .white
        title.textAlignment = .left
        
        memo.font = .systemFont(ofSize: 13)
        memo.textColor = .darkGray
        memo.textAlignment = .left

        deadline.font = .systemFont(ofSize: 13)
        deadline.textColor = .darkGray
        deadline.textAlignment = .left
        
        tagLabel.font = .systemFont(ofSize: 13)
        tagLabel.textColor = .systemCyan
        tagLabel.textAlignment = .left
        
        priority.font = .systemFont(ofSize: 15)
        priority.textColor = .systemRed
        priority.textAlignment = .right
        priority.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func configureCell(data: ReminderModel) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let unfinishedImage = UIImage(systemName: "circle",withConfiguration: config)
        let doneImage = UIImage(systemName: "checkmark.circle.fill",withConfiguration: config)
        
        if data.isDone {
            isDoneButton.setImage(doneImage, for: .normal)

        } else {
            isDoneButton.setImage(unfinishedImage, for: .normal)
        }
        title.text = data.title
        memo.text = data.memo
        deadline.text = data.deadline
        if data.tag != "" {
            tagLabel.text = "#\(data.tag ?? "")"
        } else {
            tagLabel.text = ""
        }
        var priorityText = ""
        for _ in 0..<data.priority {
            priorityText += "!"
        }
        priority.text = priorityText
    }
}
