//
//  ViewController.swift
//  project-claze
//
//  Created by 유영웅 on 2/21/25.
//

import UIKit

class ViewController: UIViewController {

    let childView = SharedExtensionViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(childView)
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        // Do any additional setup after loading the view.
    }


}

#Preview{
    ViewController()
}
