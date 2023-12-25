//
//  TodoTableViewCell.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 24/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class TodoTableViewCell: UITableViewCell {
    // MARK: Properties
    static let identifier = "TodoTableViewCellIdentifier"
    
    private var todo: Todo?
    
    // MARK: View Components
    private lazy var taskLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.font = .preferredFont(forTextStyle: .title3).bold().rounded()
        lb.textAlignment = .left
        lb.text = "The standard Lorem Ipsum passage, used since the 1500s"
        
        return lb
    }()
    
    private lazy var timeLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.font = .preferredFont(forTextStyle: .callout)
        lb.textColor = .gray
        lb.textAlignment = .left
        lb.text = "10.00 AM - 01.00 PM"
        
        return lb
    }()

    private lazy var timeClockView: UIImageView = {
        let vw = AppViewFactory.buildImageView()
        vw.image = .init(systemName: "clock")
        vw.tintColor = .gray
        
        return vw
    }()

    private lazy var descriptionLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.font = .preferredFont(forTextStyle: .subheadline)
        lb.textColor = .gray
        lb.textAlignment = .left
        lb.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        return lb
    }()
    
    private lazy var checkButton: UIButton = {
        let bt = AppViewFactory.buildImageButton(with: .preferredFont(forTextStyle: .footnote).rounded())
        bt.setImage(.init(systemName: "checkmark"), for: .normal)
        bt.layer.cornerRadius = 12.5
        bt.backgroundColor = .appPrimary
        bt.tintColor = .appSecondary
        
        return bt
    }()
    
    private lazy var importantButton: UIButton = {
        let bt = AppViewFactory.buildImageButton(with: .preferredFont(forTextStyle: .title1).rounded())
        bt.setImage(.init(systemName: "bookmark.fill"), for: .normal)
        bt.backgroundColor = .clear
        bt.tintColor = .appPrimary
        
        return bt
    }()
    
    private lazy var baseVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical

        return vw
    }()
    
    private lazy var oneTransparentView: UIView = {
        let vw = AppViewFactory.buildView()

        return vw
    }()
    
    private lazy var twoTransparentView: UIView = {
        let vw = AppViewFactory.buildView()

        return vw
    }()
    
    private lazy var threeTransparentView: UIView = {
        let vw = AppViewFactory.buildView()

        return vw
    }()
    
    private lazy var fourTransparentView: UIView = {
        let vw = AppViewFactory.buildView()

        return vw
    }()
    
    private lazy var containerVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        vw.layer.cornerRadius = 10.0
        vw.layer.shadowRadius = 5.0
        vw.layer.shadowOpacity = 0.5
        vw.backgroundColor = .appSecondary
        
        return vw
    }()
    
    private lazy var containerHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        
        return vw
    }()

    private lazy var oneVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical
        vw.alignment = .leading

        return vw
    }()
    
    private lazy var twoVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .vertical

        return vw
    }()
    
    private lazy var oneHStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        vw.axis = .horizontal
        
        return vw
    }()

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
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
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    // MARK: Functionalities
    func updateTodoCell(with todo: Todo) -> Void {
        let attributeString: NSMutableAttributedString = .init()
        attributeString.addAttribute(
            .strikethroughStyle,
            value: 2,
            range: .init(
                location: 0,
                length: attributeString.length
            )
        )
        
        self.taskLabel.attributedText = todo.hasCompleted ? attributeString : nil
        self.taskLabel.text = todo.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startTime = formatter.string(from: todo.timeStart)
        let endTime = formatter.string(from: todo.timeEnd)
        
        self.timeLabel.text = startTime + " - " + endTime
        
        self.descriptionLabel.text = todo.description
        
        self.importantButton.tintColor = todo.isImportant ? .appPrimary : .systemGray.withAlphaComponent(0.2)
        
        self.checkButton.tintColor = todo.hasCompleted ? .appSecondary : .systemGray.withAlphaComponent(0.5)
        self.checkButton.backgroundColor = todo.hasCompleted ? .appPrimary : nil
        self.checkButton.layer.borderColor = todo.hasCompleted ? nil : UIColor.systemGray.withAlphaComponent(0.5).cgColor
        self.checkButton.layer.borderWidth = todo.hasCompleted ? 0.0 : 1.0
    }
    
    private func setupViews() -> Void {
        self.contentView.addSubview(self.baseVStackView)
        
        self.baseVStackView.addArrangedSubview(self.containerVStackView)
        self.baseVStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10.0)
        }
        
        self.containerVStackView.addArrangedSubview(self.oneTransparentView)
        self.containerVStackView.addArrangedSubview(self.containerHStackView)
        self.containerVStackView.addArrangedSubview(self.twoTransparentView)
        
        self.containerHStackView.addArrangedSubview(self.threeTransparentView)
        self.containerHStackView.addArrangedSubview(self.oneVStackView)
        self.containerHStackView.setCustomSpacing(10.0, after: self.oneVStackView)
        self.containerHStackView.addArrangedSubview(self.twoVStackView)
        self.containerHStackView.addArrangedSubview(self.fourTransparentView)
        
        self.oneVStackView.addArrangedSubview(self.taskLabel)
        self.oneVStackView.setCustomSpacing(20.0, after: self.taskLabel)
        self.oneVStackView.addArrangedSubview(self.oneHStackView)
        self.oneVStackView.setCustomSpacing(10.0, after: self.oneHStackView)
        self.oneVStackView.addArrangedSubview(self.descriptionLabel)
        
        self.oneHStackView.addArrangedSubview(self.timeClockView)
        self.oneHStackView.setCustomSpacing(5.0, after: self.timeClockView)
        self.oneHStackView.addArrangedSubview(self.timeLabel)
        
        self.twoVStackView.addArrangedSubview(self.importantButton)
        self.twoVStackView.setCustomSpacing(20.0, after: self.importantButton)
        self.twoVStackView.addArrangedSubview(self.checkButton)
        
        self.importantButton.snp.makeConstraints { make in
            make.width.height.equalTo(30.0)
        }
        
        self.checkButton.snp.makeConstraints { make in
            make.width.height.equalTo(25.0)
        }
        
        self.oneTransparentView.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.twoTransparentView.snp.makeConstraints { make in
            make.height.equalTo(20.0)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.threeTransparentView.snp.makeConstraints { make in
            make.width.equalTo(10.0)
            make.verticalEdges.equalToSuperview()
        }
        
        self.fourTransparentView.snp.makeConstraints { make in
            make.width.equalTo(10.0)
            make.verticalEdges.equalToSuperview()
        }
    }

}

#if DEBUG
@available(iOS 13, *)
struct TodoTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ViewPreview(TodoTableViewCell())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
