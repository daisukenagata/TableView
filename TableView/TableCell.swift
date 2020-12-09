//
//  TableCell.swift
//  TableView
//
//  Created by 永田大祐 on 2020/12/03.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
}
