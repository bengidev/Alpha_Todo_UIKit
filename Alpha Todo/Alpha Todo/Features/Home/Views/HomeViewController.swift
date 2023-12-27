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
    private var newTask: Task?
    
    private var selectedTask: Task? {
        return self.homeViewModel.tasks[self.selectedIndexPath.row]
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
        self.setupTodoController(with: self.homeViewModel.tasks.first)
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
        self.todoController = TodoTableViewController(task: task)
        
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
        let vc = TaskViewController(height: UIScreen.main.bounds.height * 0.3)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        vc.isModalInPresentation = true
        
        
        self.present(vc, animated: true)
    }
    
    @objc
    private func didTapSaveButton(_ notification: Notification) -> Void {
        print("Save Button pressed from: \(notification.name)")
        self.dismiss(animated: true)
    }
    
    @objc
    private func didTapCategoryButton(_ notification: Notification) -> Void {
        print("Category Button pressed from: \(notification.name)")
        
        guard let indexPath = notification.object as? IndexPath else { return }
        self.selectedIndexPath = indexPath
        
        NotificationCenter.default.post(
            name: .TodoDataTaskChanged,
            object: self.homeViewModel.tasks[indexPath.row]
        )
        
        print("Selected IndexPath: \(selectedIndexPath)")
    }

    @objc
    private func didTapAddButton(_ notification: Notification) -> Void {
        print("Add Button pressed from: \(notification.name)")
        
        let newTask: Task = .init(
            category: .init(name: "Weather", imageName: "cloud.sun.rain", isSelected: false),
            todos: [
                .init(
                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                    timeStart: .init(),
                    timeEnd: .init(),
                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                    isImportant: false,
                    hasCompleted: false
                ),
                .init(
                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
                    timeStart: .init(),
                    timeEnd: .init(),
                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
                    isImportant: false,
                    hasCompleted: false
                ),
            ]
        )
        
        // If selected task category name match to new task category name,
        // update task with new todos, otherwise create new task
        if self.selectedTask?.category.name.lowercased() == newTask.category.name.lowercased() {
            self.homeViewModel.updateCurrentTask(for: self.selectedIndexPath, with: newTask.todos)
        } else {
            self.homeViewModel.addNewTask(newTask)
        }
        
        // Send trigger into TodoController for change selectedTask
        NotificationCenter.default.post(
            name: .TodoDataTaskChanged,
            object: self.selectedTask
        )
        
        // Send trigger into CategoryController for change tasks and selectedIndexPath
        NotificationCenter.default.post(
            name: .CategoryDataTasksChanged,
            object: nil,
            userInfo: [
                "Tasks" : self.homeViewModel.tasks,
                "IndexPath" : self.selectedIndexPath,
            ]
        )
        
        self.showTaskViewController()
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
