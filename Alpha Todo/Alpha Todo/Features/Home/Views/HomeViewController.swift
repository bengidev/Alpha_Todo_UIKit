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
        
        self.setupCategoryCollectionController()
    }
    
    private func setupCategoryCollectionController() -> Void {
        let categoryCollectionController = CategoryCollectionViewController(
            categories: self.homeViewModel.categories
        ) { [weak self] (indexPath) in
            print("IndexPath from setupCategoryCollectionController: \(indexPath)")
        }
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(categoryCollectionController)
        
        self.homeView.updateCategoryCollectionController(categoryCollectionController)
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
