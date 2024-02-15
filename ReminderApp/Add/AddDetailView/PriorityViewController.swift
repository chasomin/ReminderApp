//
//  PriorityViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import SnapKit

class PriorityViewController: BaseViewController {

    let segment = UISegmentedControl()
    var priorityData: ((Int, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.selectedSegmentIndex = 0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let index = segment.selectedSegmentIndex
        guard let text = segment.titleForSegment(at: index) else { return }
        priorityData?(index, text)
    }
    
    override func configureHierarchy() {
        view.addSubview(segment)
    }
    
    override func configureLayout() {
        segment.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(70)
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        segment.insertSegment(withTitle: "없음", at: 0, animated: true)
        segment.insertSegment(withTitle: "낮음", at: 1, animated: true)
        segment.insertSegment(withTitle: "중간", at: 2, animated: true)
        segment.insertSegment(withTitle: "높음", at: 3, animated: true)
    }
}
