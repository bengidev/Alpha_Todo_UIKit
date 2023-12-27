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
    private var taskView: TaskView?
    private var height: CGFloat?
    private var selectedIndexPath: IndexPath = .init(row: 0, section: 0)
    
    // MARK: Initializers
    init(height: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.height = height
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
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.taskView = TaskView(height: self.height)
        self.taskView?.updateSaveButtonHandler { task in
            
            // Send trigger into HomeController for tap Save Button
            NotificationCenter.default.post(
                name: .TaskDidTapSaveButton,
                object: task
            )
        }
        
        self.view = self.taskView
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
