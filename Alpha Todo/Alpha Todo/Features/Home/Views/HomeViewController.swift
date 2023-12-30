//
//  HomeViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 20/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class HomeViewController: UIViewController {
    // MARK: Properties
    private var homeView = HomeView()
    private var selectedIndexPath: IndexPath = .init(row: 0, section: 0)
    private var categoryController: CategoryCollectionViewController?
    private var todoController: TodoTableViewController?
    
    private var selectedTask: Task? {
        return !self.homeViewModel.tasks.isEmpty ?
        self.homeViewModel.tasks[self.selectedIndexPath.row] :
        nil
    }
    
    private let homeViewModel = HomeViewModel()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Receive trigger for tap Saved Button from TaskController
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didTapSaveButton(_:)),
            name: .TaskDidTapSaveButton,
            object: nil
        )
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
        
        self.updateViewComponents()
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.view = self.homeView
    }
    
    private func updateViewComponents() -> Void {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didTapCategoryButton(_:)),
            name: .CategoryDidTapCategoryButton,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didTapAddButton(_:)),
            name: .HomeDidTapAddButton,
            object: nil
        )
        
        self.setupCategoryController(with: self.homeViewModel.tasks)
        self.setupTodoController(with: self.selectedTask)
        self.updateViewVisibilities()
    }
    
    private func setupCategoryController(with tasks: [Task]?, hasNewTasks: Bool = false) -> Void {
        self.categoryController = CategoryCollectionViewController(tasks: tasks)
        
        // If previous controller available, remove it first
        self.categoryController?.remove()
        
        // Include that child view controller in the parent's view controller life cycle.
        //
        self.add(self.categoryController ?? .init())
        self.homeView.updateCategoryController(self.categoryController ?? .init())
    }
    
    private func setupTodoController(with task: Task?) -> Void {
        self.todoController = TodoTableViewController(homeViewModel: self.homeViewModel)
        
        // If previous controller available, remove it first
        self.todoController?.remove()
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(self.todoController ?? .init())
        self.homeView.updateTodoController(self.todoController ?? .init())
    }
    
    private func updateViewVisibilities() -> Void {
        if self.homeViewModel.tasks.isEmpty {
            self.homeView.isHiddenCategoryView(true)
            self.homeView.isHiddenTodoView(true)
            self.homeView.isHiddenEmptyTaskView(false)
            self.homeView.isHiddenSpacerView(false)
        } else {
            self.homeView.isHiddenCategoryView(false)
            self.homeView.isHiddenTodoView(false)
            self.homeView.isHiddenEmptyTaskView(true)
            self.homeView.isHiddenSpacerView(true)
        }
    }
    
    private func showTaskViewController() -> Void {
        let vc = TaskViewController(height: UIScreen.height * 0.3)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        vc.isModalInPresentation = true
        
        
        self.present(vc, animated: true)
    }
    
    @objc
    private func didTapCategoryButton(_ notification: Notification) -> Void {
        print("Category Button pressed from: \(notification.name)")
        
        guard let indexPath = notification.object as? IndexPath else { return }
        self.selectedIndexPath = indexPath
        
        // Send trigger into TodoController for change selectedCategoryIndexPath
        NotificationCenter.default.post(
            name: .TodoSelectedCategoryIndexPathChanged,
            object: self.selectedIndexPath
        )
        
        print("Selected IndexPath: \(selectedIndexPath)")
    }
    
    @objc
    private func didTapAddButton(_ notification: Notification) -> Void {
        print("Add Button pressed from: \(notification.name)")
        
        self.showTaskViewController()
    }
    
    @objc
    private func didTapSaveButton(_ notification: Notification) -> Void {
        print("Save Button pressed from: \(notification.name)")
        
        if let task = notification.object as? Task {
            
            // If selected task category name match to new task category name,
            // update task with new todos, otherwise create new task
            if self.selectedTask?.category.name.lowercased() == task.category.name.lowercased() {
                self.homeViewModel.updateCurrentTask(for: self.selectedIndexPath, with: task.todos)
            } else {
                self.homeViewModel.addNewTask(task)
            }
        }
        
        self.dismiss(animated: true) {
            self.updateViewVisibilities()
            
            // Send trigger into TodoController for change selectedTask
            NotificationCenter.default.post(
                name: .TodoSelectedTaskChanged,
                object: self.selectedTask
            )
            
            // Send trigger into TodoController for change selectedCategoryIndexPath
            NotificationCenter.default.post(
                name: .TodoSelectedCategoryIndexPathChanged,
                object: self.selectedIndexPath
            )
            
            // Send trigger into CategoryController for change tasks and selectedCategoryIndexPath
            NotificationCenter.default.post(
                name: .CategoryDataTasksChanged,
                object: nil,
                userInfo: [
                    "Tasks" : self.homeViewModel.tasks,
                    "IndexPath" : self.selectedIndexPath,
                ]
            )
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(HomeViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
