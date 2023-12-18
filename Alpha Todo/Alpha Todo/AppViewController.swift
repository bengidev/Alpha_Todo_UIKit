//
//  AppViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 18/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class AppViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .orange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

#if DEBUG
@available(iOS 13, *)
struct AppViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(AppViewController())
    }
}
#endif

