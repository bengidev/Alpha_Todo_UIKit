//
//  CategoryCollectionViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class CategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // MARK: Properties
    private var tasks: [CDAlphaTask]?
    
    // MARK: Initializers
    init(tasks: [CDAlphaTask]? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.tasks = tasks
        
        self.setupController()
        self.setupInitialSelectedCategory()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.dataTasksChanged(_:)),
            name: .CategoryDataTasksChanged,
            object: nil
        )
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
        self.collectionView.backgroundColor = .appSecondary
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
    }
    
    private func setupInitialSelectedCategory() -> Void {
        guard let tasks, !tasks.isEmpty else { return }
        
        // Reset another categories to prevent multiple selected category
        // when first open.
        for (index, _) in tasks.enumerated() {
            self.tasks?[index].isSelected = false
        }
        
        // Change selected category initial value when first opened
        self.tasks?.first?.isSelected = true
        
        // Update UICollectionView to reflect changed data for initial IndexPath
        self.collectionView.reloadItems(at: [.init(item: 0, section: 0)])
    }
    
    @objc
    private func didTapCategoryButton(_ sender: UIButton) -> Void {
        // Reset another categories to prevent multiple selected category.
        if let tasks {
            for (index, _) in tasks.enumerated() {
                if index != sender.tag {
                    self.tasks?[index].isSelected = false
                    self.collectionView.reloadItems(at: [.init(item: index, section: 0)])
                }
            }
        }
        
        NotificationCenter.default.post(
            name: .CategoryDidTapCategoryButton,
            object: IndexPath(
                item: sender.tag,
                section: 0
            )
        )
        
        guard let tasks, !tasks.isEmpty else { return }
        
        // Change selected category value when tap
        self.tasks?[sender.tag].isSelected.toggle()
        
        // Update UICollectionView to reflect changed data for selected IndexPath
        self.collectionView.reloadItems(at: [.init(item: sender.tag, section: 0)])
        
        // Move scroll into the tap category button IndexPath
        self.collectionView.scrollToItem(
            at: .init(item: sender.tag, section: 0),
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    @objc
    private func dataTasksChanged(_ notification: Notification) -> Void {
        guard let tasks = notification.userInfo?["CDAlphaTasks"] as? [CDAlphaTask],
              let indexPath = notification.userInfo?["IndexPath"] as? IndexPath,
              !tasks.isEmpty
        else { return }
        
        // Update current tasks into new tasks
        self.tasks = tasks
        
        // Update UICollectionView data with new tasks and
        // scroll it to the previous selected category button
        self.collectionView.reloadData()
        
        // Set the previous selected category button into selected form
        self.tasks?[indexPath.item].isSelected = true
        
        // Give the spare time for scrolling through the previous
        // selected category button
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: true
            )
        }
    }
    
    // MARK: DataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tasks else { return 0 }
        
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else { return .init() }
        
        let categoryButton = cell.getCategoryButton()
        categoryButton.tag = indexPath.item
        categoryButton.addTarget(self, action: #selector(self.didTapCategoryButton(_:)), for: .touchUpInside)
        
        cell.updateCategoryButton(with: self.tasks?[indexPath.item])
        
        return cell
    }
    
    // MARK: Delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        // Value minimumLineSpacingForSectionAt and minimumInteritemSpacingForSectionAt
        // should match for making UICollectionViewCell shows correctly.
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        // Value minimumLineSpacingForSectionAt and minimumInteritemSpacingForSectionAt
        // should match for making UICollectionViewCell shows correctly.
        20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
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
