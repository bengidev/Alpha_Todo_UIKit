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
    
    // MARK: Views
    private lazy var oneVStackView: UIStackView = {
        let vw = ViewFactory.buildStackView()
        
        return vw
    }()
    
    private lazy var onboardingImageView: UIImageView = {
        let vw = ViewFactory.imageView()
        vw.image = .init(named: self.onboardingImage ?? "")
        
        return vw
    }()
    
    private lazy var onboardingTitleLabel: UILabel = {
        let lb = ViewFactory.buildLabel()
        lb.text = self.onboardingTitle
        lb.font = .preferredFont(forTextStyle: .title2).rounded().bold()
        
        return lb
    }()
    
    private lazy var onboardingBodyLabel: UILabel = {
        let lb = ViewFactory.buildLabel()
        lb.text = self.onboardingBody
        lb.font = .preferredFont(forTextStyle: .body)
        lb.textColor = .gray
        
        return lb
    }()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        self.onboardingImage = ""
        self.onboardingTitle = ""
        self.onboardingBody = ""
    }
    
    init(image: String, title: String, body: String) {
        super.init(nibName: nil, bundle: nil)
        self.onboardingImage = image
        self.onboardingTitle = title
        self.onboardingBody = body
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    // MARK: Functions
    private func setupViews() -> Void {
        self.view.backgroundColor = .init(resource: .appSecondary)
        self.view.addSubview(self.oneVStackView)
        
        self.oneVStackView.addArrangedSubview(self.onboardingImageView)
        self.oneVStackView.setCustomSpacing(10.0, after: self.onboardingImageView)
        
        self.oneVStackView.addArrangedSubview(self.onboardingTitleLabel)
        self.oneVStackView.setCustomSpacing(20.0, after: self.onboardingTitleLabel)
        
        self.oneVStackView.addArrangedSubview(self.onboardingBodyLabel)
        self.oneVStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.onboardingImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view).inset(10.0)
            make.height.equalTo(self.view.frame.height / 2)
        }
        
        self.onboardingTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view).inset(10.0)
        }
        
        self.onboardingBodyLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.view).inset(10.0)
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
                title: "Your Personal Productivity Assistant Has Arrived",
                body: "Say hello to your new productivity assistant. Let our app help you tackle tasks with ease. From reminders to collaboration, we've got you covered"
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}
#endif
