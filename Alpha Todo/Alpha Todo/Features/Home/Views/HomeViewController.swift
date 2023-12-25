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
    private var selectedTask: Task? {
        didSet {
            self.setupTodoTableViewController(with: selectedTask)
        }
    }
    
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
        self.homeView.updateDataTasks(self.homeViewModel.tasks)
        self.homeView.updateAddButtonHandler { [weak self] in
            print("Add Button was tapped")
            
            self?.showTaskViewController()
            
//            let newTask: Task = .init(
//                category: .init(name: "Weather", imageName: "cloud.sun.rain", isSelected: false),
//                todos: [.init(
//                    title: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...",
//                    timeStart: .init(),
//                    timeEnd: .init(),
//                    description: "Duis non odio arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum feugiat neque vitae nisl mattis, quis efficitur libero gravida. Quisque faucibus magna eu hendrerit placerat. Mauris laoreet dictum nisl, quis vestibulum magna. Proin vehicula, nulla at aliquam efficitur, nibh dui fringilla erat, pretium aliquam odio tellus maximus augue. Donec malesuada odio at neque sollicitudin, id cursus mauris euismod.",
//                    isImportant: false,
//                    hasCompleted: false
//                ),
//                ]
//            )
//            
//            self?.homeViewModel.addNewTask(newTask)
//            self?.setupCategoryCollectionViewController(with: self?.homeViewModel.tasks, hasNewTasks: true)
        }
        
        guard !self.homeViewModel.tasks.isEmpty else { return }
        
        self.setupCategoryCollectionViewController(with: self.homeViewModel.tasks)
        self.setupTodoTableViewController(with: self.homeViewModel.tasks[0])
    }
    
    private func setupCategoryCollectionViewController(with tasks: [Task]?, hasNewTasks: Bool = false) -> Void {
        let controller = CategoryCollectionViewController(tasks: tasks) { [weak self] (indexPath) in
            self?.selectedTask = self?.homeViewModel.tasks[indexPath.row]
        }
        
        // Remove the current controller from parent if available.
        //
        // This is for the purpose of replacing the old controller and its view
        // with the new controller and its view.
        //
        if hasNewTasks {
            controller.remove()
        }
        
        // Include that child view controller in the parent's view controller life cycle.
        //
        self.add(controller)
        self.homeView.updateCategoryCollectionViewController(controller, hasRenewView: hasNewTasks)
    }
    
    private func setupTodoTableViewController(with task: Task?) -> Void {
        let controller = TodoTableViewController(task: task)
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(controller)
        self.homeView.updateTodoTableViewController(controller)
    }
    
    private func showTaskViewController() -> Void {
        let vc = TaskViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .pageSheet
        vc.isModalInPresentation = true
        
        self.present(vc, animated: true)
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
