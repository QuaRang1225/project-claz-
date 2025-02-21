//
//  SharedExtensionViewController.swift
//  project-clazé
//
//  Created by 유영웅 on 2/21/25.
//

import UIKit

class SharedExtensionViewController: UIViewController {

    var urlString:UILabel={
        let label = UILabel()
        label.text = "aa"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
//        getUrl()
    }
    func configureView(){
        view.backgroundColor = .red
        view.addSubview(urlString)
    }
    func configureLayout(){
        NSLayoutConstraint.activate([
            urlString.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlString.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func getUrl() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem,
           let itemProviders = item.attachments {
            itemProviders.forEach { itemProvider in
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                    itemProvider.loadItem(forTypeIdentifier: "public.url") { [weak self] (url, error) in
                        if let shareURL = url as? URL {
                            print(shareURL.absoluteString)
                        } else {
                            print("Error loading URL: \(error?.localizedDescription ?? "")")
                        }
                    }
                }
            }
        }
    }

}

#Preview{
    SharedExtensionViewController()
}
