//
//  SendViewController.swift
//  SharedExtension
//
//  Created by 유영웅 on 2/21/25.
//

import UIKit

class SendViewController: UIViewController {
    
    var vm:ShareViewModel!
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = vm.shared.url?.absoluteString
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false  // AutoLayout 활성화
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white  // 배경색 설정
        view.addSubview(label)
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

