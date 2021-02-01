//
//  ContactDetailsCell.swift
//  QRGenerator
//
//  Created by Mangrulkar on 28/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

protocol ContactDetailsCellDelegate {
    func deleteActionToController(cell: ContactDetailsCell)
    func shareActionToController(cell: ContactDetailsCell)
}

class ContactDetailsCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var delegate: ContactDetailsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// Update table view cell
    /// - Parameter data: data object
    func updateUI(data: UserDetails) {
        self.avtarImageView.image = UIImage(data: data.imageData)
        self.nameLabel.text = data.name
        self.numberLabel.text = data.number
    }
    
    /// Action method of share button
    /// - Parameter sender: sender object
    @IBAction func shareAction(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.shareActionToController(cell: self)
        }
    }
    
    /// Action method of delete button
    /// - Parameter sender: sender object
    @IBAction func deleteAction(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.deleteActionToController(cell: self)
        }
    }
    
}
