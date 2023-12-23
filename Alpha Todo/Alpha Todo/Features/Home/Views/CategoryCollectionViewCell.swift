//
//  CategoryCollectionViewCell.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    static let identifier = "CategoryCollectionViewCellIdentifier"

    // MARK: View Components
    private lazy var oneHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        
        return vw
    }()
    
    private lazy var categoryButton: UIButton = {
        let bt = AppViewFactory.buildImageTextButton()
        bt.contentEdgeInsets = .init(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        bt.setImage(.init(systemName: "pencil"), for: .normal)
        bt.setTitle("Tester", for: .normal)
        bt.setTitleColor(.appSecondary, for: .normal)
        bt.tintColor  = .appSecondary
        bt.backgroundColor = .appPrimary
        bt.layer.shadowRadius = 3.0
        bt.layer.shadowOpacity = 0.5
        
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialization code
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        fatalError("awakeFromNib() has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.categoryButton.setImage(nil, for: .normal)
        self.categoryButton.setTitle(nil, for: .normal)
    }
    
    func updateCategoryButton(with category: Category) -> Void {
        self.categoryButton.setTitle(category.name, for: .normal)
        self.categoryButton.setImage(.init(systemName: category.imageName), for: .normal)
        self.categoryButton.setTitleColor(category.isSelected ? .systemPink : .appSecondary, for: .normal)
        self.categoryButton.tintColor = category.isSelected ? .systemPink : .appSecondary
        
        print("Category Status: \(category)")
    }
    
    func getCategoryButton() -> UIButton {
        return self.categoryButton
    }
    
    private func setupViews() -> Void {
        self.contentView.backgroundColor = .appSecondary
        self.contentView.addSubview(self.oneHStackView)
        
        self.oneHStackView.addArrangedSubview(self.categoryButton)
        self.oneHStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.categoryButton.snp.makeConstraints { make in
            make.height.equalTo(45.0)
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct CategoryCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(CategoryCollectionViewCell())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
