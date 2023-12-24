//
//  HomeView.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 23/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class HomeView: UIView {
    // MARK: View Components
    private lazy var containerVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        
        return vw
    }()
    
    private lazy var oneHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        
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
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("awakeFromNib() has not been implemented")
    }
    
    // MARK: Functionalities
    func updateCategoryCollectionViewController(_ controller: CategoryCollectionViewController) -> Void {
        lazy var categoryCollectionView: UIView = {
            guard let vw = controller.view else { return .init() }
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            return vw
        }()
        
        self.containerVStackView.addArrangedSubview(categoryCollectionView)
        self.containerVStackView.setCustomSpacing(20.0, after: categoryCollectionView)
        categoryCollectionView.snp.makeConstraints { make in
            make.height.equalTo(65.0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func updateTodoTableViewController(_ controller: TodoTableViewController) -> Void {
        lazy var todoTableView: UIView = {
            guard let vw = controller.view else { return .init() }
            vw.translatesAutoresizingMaskIntoConstraints = false
            vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            return vw
        }()
        
        self.containerVStackView.addArrangedSubview(todoTableView)
        todoTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10.0)
        }
    }
    
    private func setupViews() -> Void {
        self.backgroundColor = .appSecondary
        self.addSubview(self.containerVStackView)
        
        self.containerVStackView.addArrangedSubview(self.oneHStackView)
        self.containerVStackView.setCustomSpacing(50.0, after: self.oneHStackView)
        self.containerVStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20.0)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
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
    }
}

#if DEBUG
@available(iOS 13, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(HomeView())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
