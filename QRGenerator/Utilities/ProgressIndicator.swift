//
//  ProgressIndicator.swift
//  QRGenerator
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//
import UIKit

open class ProgressIndicator {
    
    internal static var spinner: UIActivityIndicatorView?
    
    /// Configure and start the spinner
    /// - Parameters:
    ///   - style: indicator view style
    ///   - backColor: Background color of indicator view
    ///   - baseColor: Base color of indicator view
    public static func start(_ style: UIActivityIndicatorView.Style, _ backColor: UIColor, _ baseColor: UIColor) {
        NotificationCenter.default.addObserver(self, selector: #selector(update), name: UIDevice.orientationDidChangeNotification, object: nil)
        if spinner == nil, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            spinner!.startAnimating()
        }
    }
    
    /// Stop the spinner
    public static func stop() {
        if spinner != nil {
            spinner!.stopAnimating()
            spinner!.removeFromSuperview()
            spinner = nil
        }
    }
    
    /// Update the spiner
    @objc public static func update() {
        if spinner != nil {
            stop()
            start(.large, UIColor.black.withAlphaComponent(0.5), .orange)
        }
    }
    
}
