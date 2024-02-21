//
//  BoxViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

final class BoxViewController: BaseViewController {
    
    let tableView = UITableView()
    let repository = ReminderModelRepository()
    var data: Results<ReminderBox>!
    var boxData: ReminderBox?
    var seletedData: ((ReminderBox) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        data = repository.read()
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: BoxTableViewCell.self, id: BoxTableViewCell.id)
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .clear
        
    }

}

extension BoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxTableViewCell.id, for: indexPath) as! BoxTableViewCell
        
        cell.configureCell(data: data[indexPath.row])
        
        if data[indexPath.row] == boxData {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        boxData = data[indexPath.row]
        seletedData?(data[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
