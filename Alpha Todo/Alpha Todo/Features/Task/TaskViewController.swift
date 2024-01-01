//
//  TaskViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 25/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TaskViewController: UIViewController {
    // MARK: Properties
    private var containerHeight: CGFloat?
    private var taskView: TaskView?
    private var selectedIndexPath: IndexPath = .init(row: 0, section: 0)
    
    // MARK: Initializers
    init(containerHeight: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.containerHeight = containerHeight
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("awakeFromNib() has not been implemented")
    }
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
        
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.taskView = TaskView(containerHeight: self.containerHeight)
        self.taskView?.updateNewCategorySwitchHandler(self.didTapNewCategorySwitch(_:))
        self.taskView?.updateSaveButtonHandler(self.didTapSaveButton(_:))
        self.view = self.taskView
    }
    
    private func didTapNewCategorySwitch(_ isOn: Bool) -> Void {
        // Send trigger into HomeController for tap Save Button
        print("NewCategorySwitch: \(isOn)")
    }
    
    private func didTapSaveButton(_ task: AlphaTask?) -> Void {
        // Send trigger into HomeController for tap Save Button
        NotificationCenter.default.post(
            name: .TaskDidTapSaveButton,
            object: task
        )
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) -> Void {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            self.taskView?.updateScrollDownTaskView(with: keyboardSize.height)
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) -> Void {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            self.taskView?.updateScrollUpTaskView(with: keyboardSize.height)
        }
    }

}

#if DEBUG
@available(iOS 13, *)
struct TaskViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(TaskViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
