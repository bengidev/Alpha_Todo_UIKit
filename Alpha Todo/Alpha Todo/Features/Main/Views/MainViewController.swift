//
//  MainViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 19/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .init(resource: .appSecondary)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

#if DEBUG
@available(iOS 13, *)
struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview(MainViewController())
            .edgesIgnoringSafeArea(.all)
    }
}
#endif

