//
//  TableViewCell.swift
//  JsonPlaceholderAssigment
//
//  Created by Macintosh on 20/12/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var ComletedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
