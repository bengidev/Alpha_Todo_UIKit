//
//  TaskView.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 25/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TaskView: UIView {
    // MARK: Properties
    
    // MARK: View Components
    private lazy var baseVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        
        return vw
    }()
    
    private lazy var containerVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        vw.backgroundColor = .appSecondary
        
        return vw
    }()
    
    private lazy var taskHeaderLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Create a Task"
        lb.font = .preferredFont(forTextStyle: .title1).bold().rounded()
        lb.textColor = .black
        lb.textAlignment = .left
        
        return lb
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Task Title"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
        lb.textColor = .systemGray
        
        return lb
    }()

    private lazy var taskTitleTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Title"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .headline).rounded()
        tf.textColor = .systemGray
        
        return tf
    }()

    private lazy var taskDateTimeLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Choose Date and Time"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
        lb.textColor = .systemGray
        
        return lb
    }()

    private lazy var taskDateButton: UIButton = {
        let bt = AppViewFactory.buildImageTextButton(with: .preferredFont(forTextStyle: .headline))
        bt.setTitle("Select a date", for: .normal)
        bt.setImage(.init(systemName: "calendar.badge.plus"), for: .normal)
        bt.tintColor = .appSecondary
        bt.backgroundColor = .appPrimary
        
        return bt
    }()

    private lazy var taskTimeButton: UIButton = {
        let bt = AppViewFactory.buildImageTextButton(with: .preferredFont(forTextStyle: .headline))
        bt.setTitle("Select time", for: .normal)
        bt.setImage(.init(systemName: "clock"), for: .normal)
        bt.tintColor = .appSecondary
        bt.backgroundColor = .appPrimary
        
        return bt
    }()
    
    private lazy var getAlertLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Get alert for this task"
        lb.font = .preferredFont(forTextStyle: .headline).bold().rounded()
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var alertSwitch: UISwitch = {
        let sw = UISwitch(frame: .zero)
        sw.onTintColor = .appPrimary
        
        return sw
    }()
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
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
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.backgroundColor = .appSecondary
        self.addSubview(self.baseVStackView)
        
        self.baseVStackView.addArrangedSubview(self.containerVStackView)
        self.baseVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerVStackView.addArrangedSubview(self.taskHeaderLabel)
        self.containerVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10.0)
        }
        
        self.taskHeaderLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }

}

#if DEBUG
@available(iOS 13, *)
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(TaskView())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
