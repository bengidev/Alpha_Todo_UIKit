//
//  BaseOnboardingViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 19/12/23.
//

import UIKit

import SnapKit
import SwiftUI
import UIKit

final class BaseOnboardingViewController: UIViewController {
    // MARK: Properties
    private var onboardingImage: String?
    private var onboardingTitle: String?
    private var onboardingBody: String?
    
    // MARK: View Components
    private lazy var oneVStackView: UIStackView = {
        let vw = AppViewFactory.buildStackView()
        
        return vw
    }()
    
    private lazy var onboardingImageView: UIImageView = {
        let vw = AppViewFactory.imageView()
        vw.image = .init(named: self.onboardingImage ?? "")
        
        return vw
    }()
    
    private lazy var onboardingTitleLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = self.onboardingTitle
        lb.font = .preferredFont(forTextStyle: .title2).rounded().bold()
        
        return lb
    }()
    
    private lazy var onboardingBodyLabel: UILabel = {
        let lb = AppViewFactory.buildLabel()
        lb.text = self.onboardingBody
        lb.font = .preferredFont(forTextStyle: .body)
        lb.textColor = .gray
        
        return lb
    }()
    
    // MARK: Initializers
    init() { super.init(nibName: nil, bundle: nil) }
    
    init(image: String, title: String, body: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.onboardingImage = image
        self.onboardingTitle = title
        self.onboardingBody = body
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
        self.view.backgroundColor = .appSecondary
        self.view.addSubview(self.oneVStackView)
        
        self.oneVStackView.addArrangedSubview(self.onboardingImageView)
        self.oneVStackView.setCustomSpacing(10.0, after: self.onboardingImageView)
        
        self.oneVStackView.addArrangedSubview(self.onboardingTitleLabel)
        self.oneVStackView.setCustomSpacing(10.0, after: self.onboardingTitleLabel)
        
        self.oneVStackView.addArrangedSubview(self.onboardingBodyLabel)
        self.oneVStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.onboardingImageView.snp.makeConstraints { make in
            make.height.equalTo(self.view.frame.height / 2.4)
            make.horizontalEdges.equalTo(self.view)
        }
        
        self.onboardingTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(60.0)
            make.horizontalEdges.equalTo(self.view)
        }
        
        self.onboardingBodyLabel.snp.makeConstraints { make in
            make.height.equalTo(100.0)
            make.horizontalEdges.equalTo(self.view)
        }
    }
}

#if DEBUG
@available(iOS 13, *)
struct BaseOnboardingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(
            BaseOnboardingViewController(
                image: "Rocket",
                title: "Your Personal Productivity Assistant Has Arrivedreminders to collaboration, we've got you covered",
                body: "Say hello to your new productivity assistant. Let our app help you tackle tasks with ease. From reminders to collaboration, we've got you coveredreminders to collaboration, we've got you coveredreminders to collaboration, we've got you covered"
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}
#endif
