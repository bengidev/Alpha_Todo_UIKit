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
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
    
    private var selectedTask: Task? {
        didSet {
            self.setupTodoTableViewController()
        }
    }
    
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
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.view = self.homeView
        
        self.setupCategoryCollectionViewController()
    }
    
    private func setupCategoryCollectionViewController() -> Void {
        let controller = CategoryCollectionViewController(
            tasks: self.homeViewModel.tasks
        ) { [weak self] (indexPath) in
            self?.selectedTask = self?.homeViewModel.tasks[indexPath.row]
            
            print("Selected Task from CategoryCollectionController: \(String(describing: self?.selectedTask))")
        }
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(controller)
        
        self.homeView.updateCategoryCollectionViewController(controller)
    }
    
    private func setupTodoTableViewController() -> Void {
        let controller = TodoTableViewController(task: self.selectedTask)
        
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
