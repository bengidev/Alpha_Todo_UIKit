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
        
        self.homeView.tasks = self.homeViewModel.tasks
        self.homeView.addButtonHandler = { [weak self] in
            print("Add Button was tapped")
        }
        
        guard !self.homeViewModel.tasks.isEmpty else { return }
        
        self.setupCategoryCollectionViewController(with: self.homeViewModel.tasks)
        self.setupTodoTableViewController(with: self.homeViewModel.tasks[0])
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.view = self.homeView
    }
    
    private func setupCategoryCollectionViewController(with tasks: [Task]?) -> Void {
        let controller = CategoryCollectionViewController(tasks: tasks) { [weak self] (indexPath) in
            self?.selectedTask = self?.homeViewModel.tasks[indexPath.row]
        }
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(controller)
        self.homeView.updateCategoryCollectionViewController(controller)
    }
    
    private func setupTodoTableViewController(with task: Task?) -> Void {
        let controller = TodoTableViewController(task: task)
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(controller)
        self.homeView.updateTodoTableViewController(controller)
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
