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
    private var containerBlurHeight: CGFloat?
    private var saveButtonHandler: ((Task?) -> Void)?
    private var tapGesture: UITapGestureRecognizer?
    private var selectedDate: Date?
    private var selectedTime: Date?
    private var task: Task = .empty
    private var todo: Todo = .empty
    private var hasEditingCategory = false {
        willSet {
            print("isEditingCategory: \(hasEditingCategory)")
        }
        didSet {
            print("isEditingCategory: \(hasEditingCategory)")
        }
    }
    
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
    
    private lazy var scrollView: UIScrollView = {
        let vw = UIScrollView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
        tf.placeholder = "Enter task category"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.delegate = self
        tf.addTarget(
            self,
            action: #selector(self.didEditCategoryTextField(_:)),
            for: .editingChanged
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
        tf.placeholder = "Enter task title"
        tf.borderStyle = .roundedRect
        tf.font = .preferredFont(forTextStyle: .subheadline)
        tf.delegate = self
        tf.addTarget(
            self,
            action: #selector(self.didEditTitleTextField(_:)),
            for: .editingChanged
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

    private lazy var taskDescriptionTextView: UITextView = {
        let vw = UITextView(frame: .zero)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.text = "Enter task description"
        vw.textAlignment = .natural
        vw.textColor = .systemGray.withAlphaComponent(0.5)
        vw.font = .preferredFont(forTextStyle: .subheadline)
        vw.layer.cornerRadius = 5.0
        vw.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
        vw.layer.borderWidth = 1.0
        vw.delegate = self
        
        return vw
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
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        picker.datePickerMode = .date
        picker.contentHorizontalAlignment = .leading
        picker.addTarget(
            self,
            action: #selector(self.didSelectDatePicker(_:)),
            for: .primaryActionTriggered
        )
        
        return picker
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        picker.datePickerMode = .time
        picker.contentHorizontalAlignment = .leading
        picker.addTarget(
            self,
            action: #selector(self.didSelectTimePicker(_:)),
            for: .primaryActionTriggered
        )
        
        return picker
    }()
    
    private lazy var saveButton: UIButton = {
        let bt = AppViewFactory.buildTextButton(with: .preferredFont(forTextStyle: .headline))
        bt.setTitle("Save", for: .normal)
        bt.tintColor = .appSecondary
        bt.backgroundColor = .appPrimary
        bt.addTarget(
            self,
            action: #selector(
                self.didTapSaveButton(_:)
            ),
            for: .primaryActionTriggered
        )
        
        return bt
    }()

    private lazy var spacerView: UIView = {
        let vw = AppViewFactory.buildView()
        
        return vw
    }()
    
    // MARK: Initializers
    init(height: CGFloat? = nil) {
        super.init(frame: .zero)
        
        self.containerBlurHeight = height
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
    
    func updateScrollUpTaskView(with height: CGFloat = 0.0) -> Void {
        UIView.animate(withDuration: 0.3) {
            // Scroll up through inside scroll view with the specified size
            // or reset the latest offset
            var offset = self.scrollView.contentOffset
            offset.y = 0.0
            self.scrollView.setContentOffset(offset, animated: true)
        }
    }
    
    func updateScrollDownTaskView(with height: CGFloat = 0.0) -> Void {
        // Don't update scroll view when edit the first text field/view
        guard self.hasEditingCategory else { return }
        
        UIView.animate(withDuration: 0.3) {
            // Scroll down through inside scroll view with the specified size
            var offset = self.scrollView.contentOffset
            offset.y = height * 0.5
            self.scrollView.setContentOffset(offset, animated: true)
        }
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
            make.height.equalTo(self.containerBlurHeight ?? 0.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.oneBaseContainerView.addSubview(self.twoBaseContainerView)
        self.oneBaseContainerView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.twoBaseContainerView.addSubview(self.scrollView)
        self.twoBaseContainerView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height)
            make.horizontalEdges.equalToSuperview()
        }

        self.scrollView.addSubview(self.containerVStackView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.containerVStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(10.0)
            make.top.bottom.leading.trailing.equalToSuperview().inset(10.0)
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
        self.containerVStackView.addArrangedSubview(self.taskDescriptionTextView)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.02, after: self.taskDescriptionTextView)
        self.containerVStackView.addArrangedSubview(self.taskDateTimeLabel)
        self.containerVStackView.addArrangedSubview(self.oneHSTackView)
        self.containerVStackView.setCustomSpacing(UIScreen.height * 0.06, after: self.oneHSTackView)
        self.containerVStackView.addArrangedSubview(self.saveButton)
        self.containerVStackView.addArrangedSubview(self.spacerView)
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
        
        self.taskDescriptionTextView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.12)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.taskDateTimeLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.oneHSTackView.addArrangedSubview(self.datePicker)
        self.oneHSTackView.setCustomSpacing(UIScreen.height * 0.02, after: self.datePicker)
        self.oneHSTackView.addArrangedSubview(self.timePicker)
        self.oneHSTackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.datePicker.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(UIScreen.width).priority(.required)
        }
        
        self.timePicker.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(UIScreen.width).priority(.low)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.height * 0.05)
            make.horizontalEdges.equalToSuperview().inset(50.0)
        }
        
        self.spacerView.snp.makeConstraints { make in
            make.height.equalTo(self.containerBlurHeight ?? 0.0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc
    private func didEditCategoryTextField(_ sender: UITextField) -> Void {
        self.task.category.name = sender.text ?? ""
    }
    
    @objc
    private func didEditTitleTextField(_ sender: UITextField) -> Void {
        self.hasEditingCategory = true
        self.todo.title = sender.text ?? ""
    }
    
    @objc
    private func didSelectDatePicker(_ sender: UIDatePicker) -> Void {
        self.selectedDate = sender.date
    }
    
    @objc
    private func didSelectTimePicker(_ sender: UIDatePicker) -> Void {
        self.selectedTime = sender.date
    }
    
    @objc
    private func didTapSaveButton(_ sender: UIButton) -> Void {
        if let selectedDate, let selectedTime {
            self.todo.dueDate = Date.combine(date: selectedDate, time: selectedTime) ?? .init()
        }
        
        var newTask = self.task
        newTask.removeAllTodos()
        newTask.addNewTodo(self.todo)
        
        self.saveButtonHandler?(newTask)
    }
    
    @objc
    private func dismissKeyboard(_ sender: UITapGestureRecognizer) -> Void {
        self.taskCategoryTextField.endEditing(true)
        self.taskTitleTextField.endEditing(true)
        self.taskDescriptionTextView.endEditing(true)
        self.taskDescriptionTextView.endEditing(true)
    }

}

extension TaskView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hasEditingCategory = true
        
        textField.endEditing(true)
        
        return true
    }
}

extension TaskView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.todo.description = textView.text
        
        self.hasEditingCategory = false
        
        // Hide keyboard when user tap return in keyboard
        if textView.text == "\n" {
            textView.endEditing(true)
        }
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
