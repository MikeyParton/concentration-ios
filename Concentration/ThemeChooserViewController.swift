//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Michael Parton on 10/9/18.
//  Copyright © 2018 Michael Parton. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    let themes = [
        "Sports": ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "⛷", "🎳", "⛳️"],
        "Animals": ["🐶", "🦆", "🐹", "🐸", "🐘", "🦍", "🐓", "🐩", "🐦", "🦋", "🐙", "🐏"],
        "Faces": ["😀", "😌", "😎", "🤓", "😠", "😤", "😭", "😰", "😱", "😳", "😜", "😇"]
    ]
    
    // MARK Navigation
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitConcentrationViewController, let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
        } else if let cvc = lastSeguedToViewController, let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var lastSeguedToViewController: ConcentrationViewController?
    
    private var splitConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToViewController = cvc
                }
            }
        }
    }
}
