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
    private var categoryCollectionController = CategoryCollectionViewController()
    private var todoTableController = TodoTableViewController()
    private var selectedIndexPath: IndexPath = .init(row: 0, section: 0)
    private var selectedTask: Task?
    
    private let homeViewModel = HomeViewModel()
    
    // MARK: Initializers
    init() { super.init(nibName: nil, bundle: nil) }
    
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
            selector: #selector(self.didTapAddButton(_:)),
            name: .HomeDidTapAddButton,
            object: nil
        )
        
        self.setupCategoryController(with: self.homeViewModel.tasks)
        self.setupTodoController(with: self.homeViewModel.tasks.first)
        self.updateViewVisibilities()
    }
    
    private func setupCategoryController(with tasks: [Task]?, hasNewTasks: Bool = false) -> Void {
        let controller = CategoryCollectionViewController(tasks: tasks) { [weak self] (indexPath) in
            self?.selectedTask = self?.homeViewModel.tasks[indexPath.row]
            self?.selectedIndexPath = indexPath
        }
        
        // Include that child view controller in the parent's view controller life cycle.
        //
        self.add(controller)
        self.homeView.updateCategoryController(controller)
    }
    
    private func setupTodoController(with task: Task?) -> Void {
        let controller = TodoTableViewController(task: task)
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(controller)
        self.homeView.updateTodoController(controller)
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didTapSaveButton(_:)),
            name: .TaskDidTapSaveButton,
            object: nil
        )
        
        let vc = TaskViewController(height: UIScreen.main.bounds.height * 0.15)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        vc.isModalInPresentation = true
        
        self.present(vc, animated: true) {
            NotificationCenter.default.post(
                name: .HomeSelectedTask,
                object: self.selectedTask ?? self.homeViewModel.tasks.first ?? Task.empty,
                userInfo: nil
            )
        }
    }
    
    @objc
    private func didTapSaveButton(_ notification: Notification) -> Void {
        print("Save Button pressed from: \(notification.name)")
        self.dismiss(animated: true)
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
        
        if self.homeViewModel.tasks.contains(where: { $0.category == self.selectedTask?.category }) {
            self.homeViewModel.updateCurrentTask(for: self.selectedIndexPath , with: newTask.todos)
        } else {
            self.homeViewModel.addNewTask(newTask)
            self.setupCategoryController(with: self.homeViewModel.tasks, hasNewTasks: true)
            self.setupTodoController(with: self.homeViewModel.tasks[self.selectedIndexPath.row ])
            
            self.homeView.updateDataTasks(self.homeViewModel.tasks)
        }
        
        print("Total todos: \(self.homeViewModel.tasks[self.selectedIndexPath.row].todos.count)")
        print("Selected task: \(String(describing: self.selectedTask))")
        
        NotificationCenter.default.post(
            name: .TodoDataTaskChanged,
            object: self.selectedTask
        )
        
        //        self.showTaskViewController()
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
