//
//  CategoryCollectionViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class CategoryCollectionViewController: UICollectionViewController {
    // MARK: Properties
    private var categories: [Category]?
    
    // MARK: Initializers
    init(categories: [Category]? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.categories = categories
        self.setupController()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("awakeFromNib() has not been implemented")
    }
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Functionalities
    private func setupController() -> Void {
        self.collectionView = AppViewFactory.buildCollectionView(scrollDirection: .horizontal)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
    }
    
    @objc
    private func didTapCategoryButton(_ sender: UIButton) -> Void {
        print("Category Button was tapped at: \(sender.tag)")
    }

    
    // MARK: DataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else { return .init() }
        
        
        cell.updateCategoryButton(with: self.categories?[indexPath.item] ?? .empty)
        let categoryButton = cell.getCategoryButton()
        categoryButton.tag = indexPath.item
        categoryButton.addTarget(self, action: #selector(self.didTapCategoryButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0.0, left: 5.0, bottom: 0.0, right: 5.0)
    }
}

#if DEBUG
@available(iOS 13, *)
struct CategoryCollectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(CategoryCollectionViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
