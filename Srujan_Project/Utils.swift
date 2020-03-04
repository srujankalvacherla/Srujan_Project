//
//  Utils.swift
//  Srujan_Project
//
//  Created by Srujan k on 04/03/20.
//  Copyright © 2020 Srujan k. All rights reserved.
//

import Foundation
import UIKit

public class Utils {
    
    static let sharedInstance = Utils()
    private init(){}
    
    var myActivityIndicator: UIActivityIndicatorView!
    
    func StartActivityIndicator(obj:UIViewController) -> UIActivityIndicatorView{
        
        self.myActivityIndicator = UIActivityIndicatorView(frame:CGRect(x: 100, y: 100, width: 100, height: 100)) as UIActivityIndicatorView
        
        self.myActivityIndicator.style = .gray
        self.myActivityIndicator.center = obj.view.center
        
        obj.view.addSubview(myActivityIndicator)
        
        self.myActivityIndicator.startAnimating()
        return self.myActivityIndicator
    }
    
    func StopActivityIndicator(obj:UIViewController,indicator:UIActivityIndicatorView) -> Void{
        DispatchQueue.main.async {
            indicator.removeFromSuperview();
        }
    }
    func showAlert(viewController: UIViewController, text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: text , preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            alertController.addAction(actionOk)
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}
struct Constants {
    static let cellIdentifier = "cell"
}
