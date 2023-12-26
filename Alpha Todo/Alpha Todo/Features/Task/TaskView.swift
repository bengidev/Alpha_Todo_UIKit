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
    private var height: CGFloat?
    
    // MARK: View Components
    private lazy var baseVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        vw.backgroundColor = .black.withAlphaComponent(0.3)
        
        return vw
    }()
    
    private lazy var containerHeightView: UIView = {
        let vw = AppViewFactory.buildView()
        vw.backgroundColor = .black.withAlphaComponent(0.3)
        
        return vw
    }()
    
    private lazy var oneBaseContainerView: UIView = {
        let vw = AppViewFactory.buildView()
        vw.backgroundColor = .black.withAlphaComponent(0.3)
        
        return vw
    }()
    
    private lazy var twoBaseContainerView: UIView = {
        let vw = AppViewFactory.buildView()
        vw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vw.layer.cornerRadius = 15.0
        vw.clipsToBounds = true
        vw.backgroundColor = .appSecondary
        
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
        lb.font = .preferredFont(forTextStyle: .title3).bold().rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left
        
        return lb
    }()

    private lazy var taskTitleTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Title"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .callout)
        tf.textColor = .systemGray
        
        return tf
    }()
    
    private lazy var taskDescriptionLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Task Description"
        lb.font = .preferredFont(forTextStyle: .title3).bold().rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left
        
        return lb
    }()

    private lazy var taskDescriptionTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Description"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .callout)
        tf.textColor = .systemGray
        
        return tf
    }()

    private lazy var taskDateTimeLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Choose Date and Time"
        lb.font = .preferredFont(forTextStyle: .title3).bold().rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left

        return lb
    }()

    private lazy var oneHSTackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        vw.distribution = .fillProportionally
        
        return vw
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
    
    private lazy var twoHSTackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        vw.distribution = .fillProportionally
        
        return vw
    }()
    
    private lazy var getAlertLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Get alert for this task"
        lb.font = .preferredFont(forTextStyle: .title3).bold().rounded()
        lb.textColor = .black
        lb.textAlignment = .left
        
        return lb
    }()
    
    private lazy var alertSwitch: UISwitch = {
        let sw = UISwitch(frame: .zero)
        sw.onTintColor = .appPrimary
        
        return sw
    }()
    
    private lazy var saveButton: UIButton = {
        let bt = AppViewFactory.buildTextButton(with: .preferredFont(forTextStyle: .headline))
        bt.setTitle("Save", for: .normal)
        bt.tintColor = .appSecondary
        bt.backgroundColor = .appPrimary
        bt.addTarget(self, action: #selector(self.didTapSaveButton(_:)), for: .primaryActionTriggered)
        
        return bt
    }()

    private lazy var spacingView: UIView = {
        let vw = AppViewFactory.buildView()
        
        return vw
    }()

    // MARK: Initializers
    init(height: CGFloat? = nil) {
        super.init(frame: .zero)
        
        self.height = height
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
        self.addSubview(self.baseVStackView)
        
        self.baseVStackView.addArrangedSubview(self.containerHeightView)
        self.baseVStackView.addArrangedSubview(self.oneBaseContainerView)
        self.baseVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerHeightView.snp.makeConstraints { make in
            make.height.equalTo(self.height ?? 0.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.oneBaseContainerView.addSubview(self.twoBaseContainerView)
        self.oneBaseContainerView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.twoBaseContainerView.addSubview(self.containerVStackView)
        self.twoBaseContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.containerVStackView.addArrangedSubview(self.taskHeaderLabel)
        self.containerVStackView.setCustomSpacing(20.0, after: self.taskHeaderLabel)
        self.containerVStackView.addArrangedSubview(self.taskTitleLabel)
        self.containerVStackView.addArrangedSubview(self.taskTitleTextField)
        self.containerVStackView.setCustomSpacing(10.0, after: self.taskTitleTextField)
        self.containerVStackView.addArrangedSubview(self.taskDescriptionLabel)
        self.containerVStackView.addArrangedSubview(self.taskDescriptionTextField)
        self.containerVStackView.setCustomSpacing(10.0, after: self.taskDescriptionTextField)
        self.containerVStackView.addArrangedSubview(self.taskDateTimeLabel)
        self.containerVStackView.addArrangedSubview(self.oneHSTackView)
        self.containerVStackView.setCustomSpacing(20.0, after: self.oneHSTackView)
        self.containerVStackView.addArrangedSubview(self.twoHSTackView)
        self.containerVStackView.setCustomSpacing(30.0, after: self.twoHSTackView)
        self.containerVStackView.addArrangedSubview(self.saveButton)
        self.containerVStackView.addArrangedSubview(self.spacingView)
        self.containerVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10.0)
        }
        
        self.taskHeaderLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskTitleTextField.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDescriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDescriptionTextField.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateTimeLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.oneHSTackView.addArrangedSubview(self.taskDateButton)
        self.oneHSTackView.setCustomSpacing(10.0, after: self.taskDateButton)
        self.oneHSTackView.addArrangedSubview(self.taskTimeButton)
        self.oneHSTackView.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateButton.snp.makeConstraints { make in
            make.height.equalTo(50.0)
        }
        
        self.taskTimeButton.snp.makeConstraints { make in
            make.height.equalTo(50.0)
        }
        
        self.twoHSTackView.addArrangedSubview(self.getAlertLabel)
        self.twoHSTackView.addArrangedSubview(self.alertSwitch)
        self.twoHSTackView.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.alertSwitch.snp.makeConstraints { make in
            make.width.equalTo(50.0)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.height.equalTo(50.0)
            make.horizontalEdges.equalToSuperview().inset(50.0)
        }
    }
    
    @objc
    private func didTapSaveButton(_ sender: UIButton) -> Void {
        NotificationCenter.default.post(
            name: .TaskDidTapSaveButton,
            object: nil
        )
    }
}

#if DEBUG
@available(iOS 13, *)
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(TaskView())
            .edgesIgnoringSafeArea(.all)
            .previewLayout(.sizeThatFits)
    }
}
#endif
