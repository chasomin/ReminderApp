//
//  AddBoxIconView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class AddBoxIconView: BaseView {
    
    let stackView = UIStackView()
    let iconButtons = [UIButton(),UIButton(),UIButton(),UIButton(),UIButton(),UIButton()]
    
    var seletedIcon: ((Int) -> Void)?

    override func configureHierarchy() {
        addSubview(stackView)
        for icon in iconButtons {
            stackView.addArrangedSubview(icon)
        }
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        for button in iconButtons {
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }
    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 15

        var config = UIButton.Configuration.filled()
        config.title = ""
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.baseBackgroundColor = .systemGray3
        
        
        for index in 0..<iconButtons.count {
            config.image = BoxIcon.allCases[index].icon
            iconButtons[index].configuration = config
            
            iconButtons[index].addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
            iconButtons[index].tag = index
        }
    }
    
    @objc func iconButtonTapped(_ sender: UIButton) {
        seletedIcon?(sender.tag)
        NotificationCenter.default.post(name: NSNotification.Name("Icon"), object: nil, userInfo: ["icon":sender.tag])
    }
}
