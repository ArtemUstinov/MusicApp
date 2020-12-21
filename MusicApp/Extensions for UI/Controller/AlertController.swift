//
//  AlertController.swift
//  MusicApp
//
//  Created by Артём Устинов on 21.12.2020.
//  Copyright © 2020 Artem Ustinov. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    
    func show(_ title: Error,
              completion: @escaping (UIAlertController) -> Void) {
        
        let alertController = UIAlertController(title: "No data",
                                                message: title.localizedDescription,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            completion(alertController)
        }
    }
}
