//
//  ShareViewController.swift
//  SharedExtension
//
//  Created by 유영웅 on 2/21/25.
//

import UIKit
import Social

final class ShareViewController: SLComposeServiceViewController {
    
    var vm = ShareViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        getSharedData()
    }
    func getSharedData() {
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            // 링크를 처리
            if let itemProviders = item.attachments {
                itemProviders.forEach { itemProvider in
                    // URL 타입이 있을 경우
                    if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                        itemProvider.loadItem(forTypeIdentifier: "public.url") { (url, error) in
                            if let shareURL = url as? URL {
                                self.vm.shared.url = shareURL
                            } else {
                                print("Error loading URL: \(error?.localizedDescription ?? "")")
                            }
                        }
                    }
                    
                    // 이미지 처리
                    if itemProvider.hasItemConformingToTypeIdentifier("public.image") {
                        itemProvider.loadItem(forTypeIdentifier: "public.image") { (data, error) in
                            if let data = data as? Data {
                                self.vm.shared.image = data
                            } else {
                                print("Error loading image: \(error?.localizedDescription ?? "")")
                            }
                        }
                    }
                }
            }
        }
    }
    func presentBottomSheet() {
        let bottomSheetVC = SendViewController()
        bottomSheetVC.vm = self.vm
        if let sheet = bottomSheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()] // Bottom Sheet 크기 조절
            sheet.prefersGrabberVisible = true    // 위에 핸들바 표시
        }
        present(bottomSheetVC, animated: true)
    }
    
    //Post 버튼 활성화/비활성화
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        
        return !contentText.isEmpty //텍스트가 비어있는지 여부에 따라 활성화/비활성화
    }
    
    //Post 버튼이 눌렸을 때
    override func didSelectPost() {
        
        // Share Extension 종료
        
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    //compose View에 커스텀으로 아이템을 표시해야할 때
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        let item = SLComposeSheetConfigurationItem()
        item?.title = "친구에게 공유하기"
        item?.value = "콰랑"
        item?.tapHandler = {
            self.presentBottomSheet()
//            let viewController = SendViewController()
//            self.pushConfigurationViewController(viewController)
        }
        return [item!]
    }
    
}


