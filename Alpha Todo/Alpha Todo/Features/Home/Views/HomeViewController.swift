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
    private var selectedCategory: Set<Category> = []
    
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
    @objc
    private func didTapCategoryButton(_ sender: UIButton) -> Void {
        // Retrieve the indexPath using the tag
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        // Access the data or perform any action with the indexPath
        print("Category Button tapped in cell at indexPath: \(indexPath)")
    }
    
    private func setupViews() -> Void {
        self.view = self.homeView
        
        self.setupCategoryCollectionController()
    }
    
    private func setupCategoryCollectionController() -> Void {
        let categoryCollectionController = CategoryCollectionViewController(
            categories: self.homeViewModel.categories
        )
        
        // Include that child view controller in the parent's view controller life cycle.
        self.add(categoryCollectionController)
        
        self.homeView.updateCategoryCollectionController(categoryCollectionController)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeViewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else { return .init() }
        
        
        cell.updateCategoryButton(with: self.homeViewModel.categories[indexPath.item])
        let categoryButton = cell.getCategoryButton()
        categoryButton.tag = indexPath.item
        categoryButton.addTarget(self, action: #selector(self.didTapCategoryButton(_:)), for: .touchUpInside)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
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
