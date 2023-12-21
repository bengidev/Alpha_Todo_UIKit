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
    private var categories: [String] = [
        "Personal",
        "Work",
        "Health",
        "Finance",
        "Study",
        "SocialSocialSocial",
    ]
    
    // MARK: View Components
    private lazy var containerVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        vw.backgroundColor = .red
        return vw
    }()
    
    private lazy var oneHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        vw.backgroundColor = .blue
        return vw
    }()

    private lazy var oneVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        
        return vw
    }()

    private lazy var helloLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.textAlignment = .left
        lb.text = "Hello,"
        lb.font = .preferredFont(forTextStyle: .largeTitle).rounded()
        lb.textColor = .gray

        return lb
    }()

    private lazy var nameLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.textAlignment = .left
        lb.text = "Lorem Ipsum Torum"
        lb.font = .preferredFont(forTextStyle: .title1).bold().rounded()
        lb.textColor = .black
        
        return lb
    }()
    
    private lazy var profileImageView: UIImageView = {
        let vw = AppViewFactory.imageView()
        vw.image = .init(named: "Building")
        vw.layer.cornerRadius = 10.0
        vw.clipsToBounds = true
        
        return vw
    }()

    private lazy var categoryCollectionView: UICollectionView = {
        let vw = AppViewFactory.buildCollectionView(scrollDirection: .horizontal)
        vw.dataSource = self
        vw.delegate = self
        vw.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier
        )
        
        return vw
    }()
    
    // MARK: Lifecycles
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .appSecondary
        self.setupViews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Functionalities
    private func setupViews() -> Void {
        self.view.addSubview(self.containerVStackView)
        
        self.containerVStackView.addArrangedSubview(self.oneHStackView)
        self.containerVStackView.addArrangedSubview(self.categoryCollectionView)
        self.containerVStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        self.oneHStackView.addArrangedSubview(self.oneVStackView)
        self.oneHStackView.addArrangedSubview(self.self.profileImageView)
        self.oneHStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
        }
        
        self.profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100.0)
        }
        
        self.oneVStackView.addArrangedSubview(self.helloLabel)
        self.oneVStackView.addArrangedSubview(self.nameLabel)
        
        self.helloLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(65.0)
            make.horizontalEdges.equalToSuperview().inset(10.0)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else { return .init() }
        
        cell.updateViews(title: self.categories[indexPath.item], systemImage: "\(indexPath.item).circle")
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
