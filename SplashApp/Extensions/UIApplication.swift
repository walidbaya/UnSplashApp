//
//  UIApplication.swift
//  SplashApp
//
//  Created by Baya Walid on 03/10/2022.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    private class func _share(_ data: [Any],
                                  applicationActivities: [UIActivity]?,
                                  setupViewControllerCompletion: ((UIActivityViewController) -> Void)?) {
            let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
            setupViewControllerCompletion?(activityViewController)
        UIApplication.topViewController()?.present(activityViewController, animated: true, completion: nil)
        }

        class func share(_ data: Any...,
                         applicationActivities: [UIActivity]? = nil,
                         setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
            _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
        }
        class func share(_ data: [Any],
                         applicationActivities: [UIActivity]? = nil,
                         setupViewControllerCompletion: ((UIActivityViewController) -> Void)? = nil) {
            _share(data, applicationActivities: applicationActivities, setupViewControllerCompletion: setupViewControllerCompletion)
        }
    
}
