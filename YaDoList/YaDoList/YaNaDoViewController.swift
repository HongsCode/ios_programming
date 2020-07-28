//
//  YaNaDoViewController.swift
//  YaDoList
//
//  Created by HongYeol on 2020/07/28.
//  Copyright © 2020 HY. All rights reserved.
//

import UIKit

class YaNaDoViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    @IBOutlet weak var isTodayButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let yanadoListViewModel = YaNaDoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let todo = YaNaDoManager.shared.createYaNaDo(detail: "Ekqhd", isToday: true)
//        let todo2 = YaNaDoManager.shared.createYaNaDo(detail: "qweqeqeqweqe", isToday: false)
//        yanadoListViewModel.addYaNaDo(todo)
//        yanadoListViewModel.addYaNaDo(todo2)
//
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
        yanadoListViewModel.loadTasks()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let todo = Storage.restoreTodo("test.json")
//        print("----YaNaDo = \(todo)")
    }
    @IBAction func isTodayButtonTapped(_ sender:Any) {
        isTodayButton.isSelected = !isTodayButton.isSelected
    }
    
    @IBAction func addTaskButtonTapped(_ sender:Any) {
        guard let detail = inputTextField.text, detail.isEmpty == false else { return }
        let todo = YaNaDoManager.shared.createYaNaDo(detail: detail, isToday: isTodayButton.isSelected)
        
        yanadoListViewModel.addYaNaDo(todo)
        collectionview.reloadData()
        inputTextField.text = ""
        isTodayButton.isSelected = false
        
    }
    
    @IBAction func tapBG(_ sender: Any) {
        inputTextField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension YaNaDoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: 섹션 몇개
        return yanadoListViewModel.numOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return yanadoListViewModel.todayYaNaDo.count
        } else {
            return yanadoListViewModel.upcomingYaNaDo.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YaNaDoListCell", for: indexPath) as? YaNaDoListCell else { return UICollectionViewCell() }
        
        var yanado:YaNaDo
        print("index.section = \(indexPath.section)")
        if indexPath.section == 0 {
            yanado = yanadoListViewModel.todayYaNaDo[indexPath.item]
        } else {
            yanado = yanadoListViewModel.upcomingYaNaDo[indexPath.item]
        }
        cell.updateUI(yanado: yanado)
        
        //delete, check handler
        //var doneButtonHandler: ((Bool) -> Void)?
        cell.doneButtonTapHandler = {
            isDone -> Void in
            yanado.isDone = isDone
            self.yanadoListViewModel.updateYaNaDo(yanado)
            self.collectionview.reloadData()
        }
        
        cell.deleteButtonTapHandler = { self.yanadoListViewModel.delteYaNaDo(yanado)
            self.collectionview.reloadData()
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "YaNaDoListHeaderView", for: indexPath) as? YaNaDoListHeaderView else {
                return UICollectionReusableView()
            }
            guard let section = YaNaDoViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
//            if self.yanadoListViewModel.upcomingYaNaDo.count == 0 {
//                return UICollectionReusableView()
//            } else if self.yanadoListViewModel.todayYaNaDo.count == 0 {
//                return UICollectionReusableView()
//            }
            
            
            header.sectionTitleLabel.text = section.title
            print("title  = \(header.sectionTitleLabel.text)")
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

extension YaNaDoViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            inputViewBottom.constant = adjustmentHeight
        } else {
            inputViewBottom.constant = 0
        }
        
    }
}
extension YaNaDoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = collectionView.bounds.width
        let height:CGFloat = 50
        return CGSize(width:width, height:height)
    }
}
class YaNaDoListCell:UICollectionViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var strikeThroughView: UIView!
    @IBOutlet weak var strikeThroughWidth: NSLayoutConstraint!
    
    var doneButtonTapHandler: ((Bool) -> Void)?
    var deleteButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func showStrikeThrough(_ show:Bool) {
        if show {
            strikeThroughWidth.constant = descriptionLabel.bounds.width
        } else {
            strikeThroughWidth.constant = 0
        }
    }
    func reset() {
        descriptionLabel.alpha = 1
        deleteButton.isHidden = true
        showStrikeThrough(false)
    }
    
    func updateUI(yanado:YaNaDo) {
        checkButton.isSelected =  yanado.isDone
        descriptionLabel.text = yanado.detail
        descriptionLabel.alpha = yanado.isDone ? 0.2 : 1
        deleteButton.isHidden = yanado.isDone == false
        showStrikeThrough(yanado.isDone)
    }
    
    @IBAction func checkButtonTap(_ sender:Any) {
        checkButton.isSelected = !checkButton.isSelected
        let isDone = checkButton.isSelected
        showStrikeThrough(isDone)
        descriptionLabel.alpha = isDone ? 0.2 : 1
        deleteButton.isHidden = !isDone
        doneButtonTapHandler?(isDone)
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        // TODO: deleteButton 처리
        deleteButtonTapHandler?()
    }
}

class YaNaDoListHeaderView: UICollectionReusableView {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
