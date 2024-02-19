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
    let image = UIImageView()
    
    let titlePriorityHStack = UIStackView()
    let dateTagHStack = UIStackView()
    let vstackView = UIStackView()
    private let repository = ReminderModelRepository()
    
    override func configureHierarchy() {
        contentView.addSubview(isDoneButton)
        contentView.addSubview(vstackView)
        contentView.addSubview(image)
        
        titlePriorityHStack.addArrangedSubview(priority)
        titlePriorityHStack.addArrangedSubview(title)

        dateTagHStack.addArrangedSubview(deadline)
        dateTagHStack.addArrangedSubview(tagLabel)
        
        vstackView.addArrangedSubview(titlePriorityHStack)
        vstackView.addArrangedSubview(memo)
        vstackView.addArrangedSubview(dateTagHStack)
        
    }

    override func configureLayout() {
        isDoneButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.width.equalTo(30)
        }
        
        vstackView.snp.makeConstraints { make in
            make.leading.equalTo(isDoneButton.snp.trailing).offset(10)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        title.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        memo.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        
        deadline.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(20)
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide)
            make.centerY.equalToSuperview()
            make.leading.equalTo(vstackView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    override func configureView() {
        titlePriorityHStack.axis = .horizontal
        titlePriorityHStack.spacing = 5
        titlePriorityHStack.distribution = .fill
        
        dateTagHStack.axis = .horizontal
        dateTagHStack.spacing = 5
        dateTagHStack.distribution = .fill
        
        vstackView.axis = .vertical
        vstackView.spacing = 5
        vstackView.distribution = .equalSpacing
        
        isDoneButton.tintColor = .systemGray4
        
        backgroundColor = .black
        title.font = .boldSystemFont(ofSize: 17)
        title.textColor = .white
        title.textAlignment = .left
        title.numberOfLines = 1
        
        memo.font = .systemFont(ofSize: 13)
        memo.textColor = .darkGray
        memo.textAlignment = .left
        memo.numberOfLines = 0

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
        
        image.contentMode = .scaleToFill
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
        if data.memo == "" {
            memo.isHidden = true
        } else {
            memo.isHidden = false
            memo.text = data.memo
        }
        deadline.text = data.deadline.dateToString()
        if data.tag != "" {
            tagLabel.text = "#\(data.tag ?? "")"
        } else {
            tagLabel.text = ""
        }
        var priorityText = ""
        for _ in 0..<data.priority {
            priorityText += "!"
        }
        
        if priorityText.isEmpty {
            priority.isHidden = true
        } else {
            priority.isHidden = false
            priority.text = priorityText
        }
    }
}
