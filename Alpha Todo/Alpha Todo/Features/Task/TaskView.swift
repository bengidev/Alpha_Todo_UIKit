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
    private var saveButtonHandler: ((Task?) -> Void)?
    private var tapGesture: UITapGestureRecognizer?
    private var task: Task = .empty
    private var todo: Todo = .empty
    
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
        lb.textAlignment = .left
        
        return lb
    }()
    
    private lazy var taskCategoryLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Task Category"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left
        
        return lb
    }()

    private lazy var taskCategoryTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Category"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.delegate = self
        tf.addTarget(
            self,
            action: #selector(self.didEditCategoryTextField(_:)),
            for: .editingDidEnd
        )
        
        return tf
    }()
    
    private lazy var taskTitleLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Task Title"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left
        
        return lb
    }()

    private lazy var taskTitleTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Title"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.delegate = self
        tf.addTarget(
            self,
            action: #selector(self.didEditTitleTextField(_:)),
            for: .editingDidEnd
        )
        
        return tf
    }()
    
    private lazy var taskDescriptionLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Task Description"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
        lb.textColor = .systemGray
        lb.textAlignment = .left
        
        return lb
    }()

    private lazy var taskDescriptionTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Task Description"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.delegate = self
        tf.addTarget(
            self,
            action: #selector(self.didEditDescriptionTextField(_:)),
            for: .editingDidEnd
        )
        
        return tf
    }()

    private lazy var taskDateTimeLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = "Choose Date and Time"
        lb.font = .preferredFont(forTextStyle: .headline).rounded()
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
    
    private lazy var taskDateTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Selected Date"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.isUserInteractionEnabled = false
        
        return tf
    }()
    
    private lazy var taskTimeTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Selected Time"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.isUserInteractionEnabled = false
        
        return tf
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
        self.setupTapGesture()
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
    func updateSaveButtonHandler(_ action: ((Task?) -> Void)?) -> Void {
        self.saveButtonHandler = action
    }
    
    private func setupTapGesture() -> Void {
        self.tapGesture = .init(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.addGestureRecognizer(self.tapGesture ?? .init())
    }

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
            make.height.equalTo(UIScreen.height)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.twoBaseContainerView.addSubview(self.containerVStackView)
        self.twoBaseContainerView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height)
            make.horizontalEdges.equalToSuperview()
        }

        self.containerVStackView.addArrangedSubview(self.taskHeaderLabel)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.03, after: self.taskHeaderLabel)
        self.containerVStackView.addArrangedSubview(self.taskCategoryLabel)
        self.containerVStackView.addArrangedSubview(self.taskCategoryTextField)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.02, after: self.taskCategoryTextField)
        self.containerVStackView.addArrangedSubview(self.taskTitleLabel)
        self.containerVStackView.addArrangedSubview(self.taskTitleTextField)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.02, after: self.taskTitleTextField)
        self.containerVStackView.addArrangedSubview(self.taskDescriptionLabel)
        self.containerVStackView.addArrangedSubview(self.taskDescriptionTextField)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.02, after: self.taskDescriptionTextField)
        self.containerVStackView.addArrangedSubview(self.taskDateTimeLabel)
        self.containerVStackView.addArrangedSubview(self.oneHSTackView)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.01, after: self.oneHSTackView)
        self.containerVStackView.addArrangedSubview(self.twoHSTackView)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.04, after: self.twoHSTackView)
        self.containerVStackView.addArrangedSubview(self.saveButton)
        self.containerVStackView.addArrangedSubview(self.spacingView)
        self.containerVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10.0)
        }
        
        self.taskHeaderLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskCategoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskCategoryTextField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskTitleTextField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDescriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDescriptionTextField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateTimeLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.oneHSTackView.addArrangedSubview(self.taskDateButton)
        self.oneHSTackView.setCustomSpacing(UIScreen.height * 0.02, after: self.taskDateButton)
        self.oneHSTackView.addArrangedSubview(self.taskTimeButton)
        self.oneHSTackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateButton.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
        }
        
        self.taskTimeButton.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
        }
        
        self.twoHSTackView.addArrangedSubview(self.taskDateTextField)
        self.twoHSTackView.setCustomSpacing(10.0, after: self.taskDateTextField)
        self.twoHSTackView.addArrangedSubview(self.taskTimeTextField)
        self.twoHSTackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateTextField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
        }
        
        self.taskTimeTextField.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.06)
            make.horizontalEdges.equalToSuperview().inset(50.0)
        }
    }
    
    @objc
    private func didTapSaveButton(_ sender: UIButton) -> Void {
        var newTask = self.task
        newTask.clearTodos()
        newTask.addNewTodo(self.todo)
        
        print("New Task: \(newTask)")
        
        self.saveButtonHandler?(newTask)
    }
    
    @objc
    private func didEditCategoryTextField(_ sender: UITextField) -> Void {
        self.task.category.name = sender.text ?? ""
    }
    
    @objc
    private func didEditTitleTextField(_ sender: UITextField) -> Void {
        self.todo.title = sender.text ?? ""
    }
    
    @objc
    private func didEditDescriptionTextField(_ sender: UITextField) -> Void {
        self.todo.description = sender.text ?? ""
    }
    
    private func didTapDateButton(_ sender: UIButton) -> Void {

        
    }

    
    @objc
    private func dismissKeyboard(_ sender: UITapGestureRecognizer) -> Void {
        self.taskCategoryTextField.endEditing(true)
        self.taskTitleTextField.endEditing(true)
        self.taskDescriptionTextField.endEditing(true)
    }

}

extension TaskView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
        return true
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
