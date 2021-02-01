//
//  ColorPickerViewController.swift
//  QRGenerator
//
//  Created by Mangrulkar on 29/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    // Global variables
    var tag: Int = 0
    var color: UIColor = UIColor.gray
    var delegate: ContactViewController? = nil
    
    /// Convert hex string value to color
    /// - Parameter hex: Hex code
    /// - Returns: Color object
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        //Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

//MARK:- Collection view delegate methods
extension ColorPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 16
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell\(indexPath.row + 1)", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.tag = tag
        tag = tag + 1
        
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var colorPalette: Array<String>
        
        // Get colorPalette array from plist file
        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
        let pListArray = NSArray(contentsOfFile: path!)
        
        if let colorPalettePlistFile = pListArray {
            colorPalette = colorPalettePlistFile as! [String]
            
            let cell: UICollectionViewCell  = collectionView.cellForItem(at: indexPath)! as UICollectionViewCell
            let hexString = colorPalette[cell.tag]
            color = hexStringToUIColor(hexString)
            delegate?.viewModel.setButtonColor(color,tag: self.view.tag, hexSting: hexString)
        }
    }
    
}
