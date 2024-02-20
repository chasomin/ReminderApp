//
//  AddBoxColorView.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit

final class AddBoxColorView: BaseView {
    
    let stackView = UIStackView()
    let colorButtons = [UIButton(),UIButton(),UIButton(),UIButton(),UIButton(),UIButton()]
    var selectedColorButton: ((Int) -> Void)?
    
    override func configureHierarchy() {
        addSubview(stackView)
        for button in colorButtons {
            stackView.addArrangedSubview(button)
        }
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        for button in colorButtons {
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }
        

    }
    
    override func configureView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        let colorList = BoxColor.allCases
        var config = UIButton.Configuration.filled()
        config.title = ""
        config.cornerStyle = .capsule
        config.buttonSize = .large
        
        for index in 0..<colorButtons.count {
            colorButtons[index].tintColor = colorList[index].color
            colorButtons[index].configuration = config
            
            colorButtons[index].addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
            colorButtons[index].tag = index
        }
    }
    
    @objc func colorButtonTapped(_ sender: UIButton) {
        selectedColorButton?(sender.tag)
        NotificationCenter.default.post(name: NSNotification.Name("Color"), object: nil, userInfo: ["color":sender.tag])


        print(#function)
    }
}
