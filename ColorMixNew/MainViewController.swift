//
//  MainViewController.swift
//  ColorMixNew
//
//  Created by Ilya Yushkov on 29.06.2021.
//

import UIKit

protocol RGBViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let colorVC = segue.destination as! RGBViewController
        colorVC.delegate = self
        colorVC.viewColor = view.backgroundColor
        
    }
}

extension MainViewController: RGBViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
