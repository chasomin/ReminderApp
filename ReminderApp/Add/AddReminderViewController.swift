//
//  AddReminderViewController.swift
//  ReminderApp
//
//  Created by 차소민 on 2/14/24.
//

import UIKit
import RealmSwift

final class AddReminderViewController: UIViewController {
    
    private let mainView = AddReminderView()
    var realmData: ReminderModel = ReminderModel(title: "", memo: "", deadline: Date(), tag: "", priority: 0)
    var deleteData: ReminderModel = ReminderModel(title: "", memo: "", deadline: Date(), tag: "", priority: 0)
    var delegate: ReloadDelegate?
    private var barButton = UIBarButtonItem()
    var navigationRigthButtonTitle = "추가"
    var barButtonIsEnabled = false
    var id: ObjectId = ObjectId()
    var deleteButtonIsHidden = true
    private let repository = ReminderModelRepository()
    var pickedImage = UIImage() {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationTitle(title: "새로운 할 일", isLarge: false)
        setNavigationRightBarButton(button: &barButton,
                                    title: navigationRigthButtonTitle, image: nil,
                                    action: navigationRigthButtonTitle == "추가" ? #selector(addButtonTapped) : #selector(updateButtonTapped))
        barButton.isEnabled = barButtonIsEnabled
        
        setNavigationLeftBarButton(title: "취소", image: nil, action: #selector(cancelButtonTapped))
        mainView.deleteButton.isHidden = deleteButtonIsHidden
        mainView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        let tableView = mainView.tableView
        setTableView(tableView: tableView, delegate: self, dataSource: self, cell: AddReminderTitleTableViewCell.self, id: AddReminderTitleTableViewCell.id)
        tableView.register(AddReminderMemoTableViewCell.self, forCellReuseIdentifier: AddReminderMemoTableViewCell.id)
        tableView.register(AddDetailTableViewCell.self, forCellReuseIdentifier: AddDetailTableViewCell.id)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tagMessageReceivedNotification), name: NSNotification.Name("TagMessage"), object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.tableView.reloadData()
    }
    
    @objc func addButtonTapped() {
        repository.createItem(realmData)
        saveImageToDocument(image: pickedImage, filename: "\(realmData.id)")
        delegate?.reload()
        dismiss(animated: true)
    }
    
    @objc func updateButtonTapped() {
        repository.updateItem(id: id, title: realmData.title, memo: realmData.memo, deadline: realmData.deadline, tag: realmData.tag, priority: realmData.priority)
        saveImageToDocument(image: pickedImage, filename: "\(id)")
        delegate?.reload()
        dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func tagMessageReceivedNotification(notification: NSNotification) {
        if let value = notification.userInfo?["tag"] as? String {
            realmData.tag = value
        }
    }
    
    //TODO: 삭제버튼 눌렀을 때 alert
    @objc func deleteButtonTapped() {
        deleteImageToDocument(filename: "\(id)")
        repository.deleteItem(deleteData)
        dismiss(animated: true)
        delegate?.reload()
    }
}




extension AddReminderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        AddReminderCellList.allCases.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderTitleTableViewCell.id, for: indexPath) as! AddReminderTitleTableViewCell
                cell.configureCell(text: realmData.title, delegate: self)
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddReminderMemoTableViewCell.id, for: indexPath) as! AddReminderMemoTableViewCell
                cell.configureCell(text: realmData.memo ?? "", delegate: self)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailTableViewCell.id, for: indexPath) as! AddDetailTableViewCell
            
            for list in AddReminderCellList.allCases {
                if indexPath.section == list.rawValue {
                    cell.configureCell(cellList: list, data: realmData, image: pickedImage)
                }
            }
            if indexPath.section == 4 {
                cell.image.isHidden = false
            } else {
                cell.image.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        for list in AddReminderCellList.allCases {
            if indexPath.section == list.rawValue {
                return list.setCellSize()
            }
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DeadlineViewController()
            vc.date = { value in
                self.realmData.deadline = value
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.section == 2 {
            navigationController?.pushViewController(TagViewController(), animated: true)
        } else if indexPath.section == 3 {
            let vc = PriorityViewController()
            vc.priorityData = { index, text in
                self.realmData.priority = index
                print(index)
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 4 {
            let cameraButton = UIAlertAction(title: "새로운 사진 찍기", style: .default) { _ in
                
            }
            let albumButton = UIAlertAction(title: "앨범에서 가져오기", style: .default) { _ in
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true)
            }
            
            let webImageButton = UIAlertAction(title: "웹에서 이미지 검색하기", style: .default) { UIAlertAction in
                
            }
            showAlert(style: .actionSheet, title: nil, message: nil, buttons: [cameraButton, albumButton, webImageButton])
        }
    }
}

extension AddReminderViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text != "" {
            realmData.title = textField.text!
            barButton.isEnabled = true
        } else {
            barButton.isEnabled = false
        }
    }
}

extension AddReminderViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        realmData.memo = textView.text
    }
}

extension AddReminderViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        pickedImage = image
        dismiss(animated: true)
    }
}
