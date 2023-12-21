//
//  AppViewFactory.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 21/12/23.
//

import UIKit

final class AppViewFactory: NSObject {
    private override init() {
        super.init()
    }
    
    class func buildView() -> UIView {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return vw
    }
    
    class func buildImageTextButton() -> UIButton {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bt.titleLabel?.font = .preferredFont(forTextStyle: .headline).rounded()
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.titleLabel?.textAlignment = .center
        bt.tintColor = .label
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 15.0
        bt.titleEdgeInsets.right = -10
        bt.imageEdgeInsets.left = -10
        
        return bt
    }
    
    class func buildTextButton() -> UIButton {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bt.titleLabel?.font = .preferredFont(forTextStyle: .headline).rounded()
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        bt.titleLabel?.textAlignment = .center
        bt.tintColor = .label
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 15.0
        
        return bt
    }
    
    class func buildImageButton() -> UIButton {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bt.tintColor = .label
        bt.backgroundColor = .systemBlue
        bt.setPreferredSymbolConfiguration(
            .init(
                font: .preferredFont(forTextStyle: .headline).rounded(),
                scale: .default
            ),
            forImageIn: .normal
        )
        
        return bt
    }
    
    class func buildLabel() -> UILabel {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        lb.textAlignment = .center
        lb.textColor = .label
        lb.numberOfLines = 0
        lb.adjustsFontSizeToFitWidth = true
        
        return lb
    }
    
    class func buildTextView() -> UITextView {
        let vw = UITextView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.textAlignment = .center
        vw.textColor = .label
        vw.textContainerInset = .init(
            top: 10.0,
            left: 10.0,
            bottom: 10.0,
            right: 10.0
        )
        
        return vw
    }
    
    class func buildStackView() -> UIStackView {
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.axis = .vertical
        vw.alignment = .center
        vw.distribution = .fill
        
        return vw
    }
    
    class func buildTableView() -> UITableView {
        let vw = UITableView(frame: .zero, style: .grouped)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.allowsSelection = true
        vw.separatorStyle = .none
        vw.rowHeight = UITableView.automaticDimension
        vw.estimatedRowHeight = 250.0
        
        return vw
    }
    
    class func imageView() -> UIImageView {
        let vw = UIImageView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.setContentHuggingPriority(.defaultLow, for: .vertical)
        vw.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        vw.setContentHuggingPriority(.defaultLow, for: .horizontal)
        vw.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return vw
    }
}




