//
//  ViewController.swift
//  Alpha Todo
//
//  Created by Bambang Tri Rahmat Doni on 07/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .orange
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        print("Hello, ViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
