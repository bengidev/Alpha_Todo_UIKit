//
//  HomeView.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class HomeView: UIView {
    // MARK: Properties
    private var tasks: [Task]?
    
    private let categoryViewTag = 1
    private let todoViewTag = 2
    
    // MARK: View Components
    private lazy var containerVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        
        return vw
    }()
    
    private lazy var oneHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        
        return vw
    }()
    
    private lazy var oneVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        
        return vw
    }()
    
    private lazy var helloLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.textAlignment = .left
        lb.text = "Hello,"
        lb.font = .preferredFont(forTextStyle: .largeTitle).rounded()
        lb.textColor = .gray
        
        return lb
    }()
    
    private lazy var nameLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.textAlignment = .left
        lb.text = "Lorem Ipsum Torum"
        lb.font = .preferredFont(forTextStyle: .title1).bold().rounded()
        
        return lb
    }()
    
    private lazy var profileImageView: UIImageView = {
        let vw = AppViewFactory.buildImageView()
        vw.image = .init(named: "Building")
        vw.layer.cornerRadius = 10.0
        vw.clipsToBounds = true
        
        return vw
    }()
    
    private lazy var addButton: UIButton = {
        let bt = AppViewFactory.buildImageButton(with: .preferredFont(forTextStyle: .title2).bold().rounded())
        bt.setImage(.init(systemName: "plus"), for: .normal)
        bt.layer.cornerRadius = 15.0
        bt.backgroundColor = .appPrimary
        bt.tintColor = .appSecondary
        bt.addTarget(self, action: #selector(self.didTapAddButton(_:)), for: .primaryActionTriggered)
        
        return bt
    }()
    
    private lazy var emptyTaskView: UIStackView = {
        let sv = AppViewFactory.buildStackView()
        sv.axis = .vertical
        
        let ig = AppViewFactory.buildImageView()
        ig.image = .init(named: "EmptyData")
        ig.contentMode = .scaleAspectFit
        
        let lb = AppViewFactory.buildLabel()
        lb.text = "Your data is empty. Please create new one."
        lb.font = .preferredFont(forTextStyle: .title2).bold().rounded()
        
        sv.addArrangedSubview(ig)
        sv.addArrangedSubview(lb)
        
        return sv
    }()
    
    private lazy var spacerView: UIView = {
        let vw = AppViewFactory.buildView()
        
        return vw
    }()


    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    @available (*, unavailable)
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
    func updateDataTasks(_ tasks: [Task]?) -> Void {
        self.tasks = tasks
        
    }
    
    func updateCategoryController(_ controller: CategoryCollectionViewController) -> Void {
        lazy var categoryCollectionView: UIView = {
            guard let vw = controller.view else { return .init() }
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vw.tag = self.categoryViewTag
            
            return vw
        }()
        
        self.containerVStackView.addArrangedSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(65.0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func getCategoryView() -> UIView {
        if let view = self.viewWithTag(self.categoryViewTag) {
            return view
        }
        
        return .init(frame: .zero)
    }
    
    func isHiddenCategoryView(_ isHidden: Bool = false) -> Void {
        if let view = self.viewWithTag(self.categoryViewTag) {
            view.isHidden = isHidden
        }
    }
    
    func updateTodoController(_ controller: TodoTableViewController) -> Void {
        lazy var todoTableView: UIView = {
            guard let vw = controller.view else { return .init() }
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vw.tag = self.todoViewTag
            
            return vw
        }()
        
        self.containerVStackView.addArrangedSubview(todoTableView)
        todoTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func getTodoView() -> UIView {
        if let view = self.viewWithTag(self.todoViewTag) {
            return view
        }
        
        return .init(frame: .zero)
    }

    func isHiddenTodoView(_ isHidden: Bool = false) -> Void {
        if let view = self.viewWithTag(self.todoViewTag) {
            view.isHidden = isHidden
        }
    }
    
    func isHiddenEmptyTaskView(_ isHidden: Bool = false) -> Void {
        self.emptyTaskView.isHidden = isHidden
    }
    
    func isHiddenSpacerView(_ isHidden: Bool = false) -> Void {
        self.spacerView.isHidden = isHidden
        self.containerVStackView.setCustomSpacing(
            isHidden ? 30.0 : UIScreen.height * 0.15,
            after: self.oneHStackView
        )
    }
    
    private func setupViews() -> Void {
        self.backgroundColor = .appSecondary
        self.addSubview(self.containerVStackView)
        self.addSubview(self.addButton)
        
        self.containerVStackView.addArrangedSubview(self.oneHStackView)
        self.containerVStackView.addArrangedSubview(self.emptyTaskView)
        self.containerVStackView.addArrangedSubview(self.spacerView)
        self.containerVStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.oneHStackView.addArrangedSubview(self.oneVStackView)
        self.oneHStackView.addArrangedSubview(self.self.profileImageView)
        self.oneHStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
        }
        
        self.profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.height * 0.12)
        }
        
        self.oneVStackView.addArrangedSubview(self.helloLabel)
        self.oneVStackView.addArrangedSubview(self.nameLabel)
        
        self.helloLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.emptyTaskView.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.height * 0.35)
        }
        
        self.spacerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.addButton.snp.makeConstraints { make in
            make.width.height.equalTo(UIScreen.height * 0.08)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(20.0)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(20.0)
        }
    }
    
    @objc
    private func didTapAddButton(_ sender: UIButton) -> Void {
        NotificationCenter.default.post(
            name: .HomeDidTapAddButton,
            object: nil
        )
    }
}

#if DEBUG
@available(iOS 13, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(HomeView())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
