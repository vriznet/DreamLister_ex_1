//
//  ItemCell.swift
//  DreamLister_ex_1
//
//  Created by vriz on 2018. 6. 26..
//  Copyright © 2018년 vriz. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    func configureCell(item: Item){
        titleLbl.text = item.title
        priceLbl.text = "$\(item.price)"
        detailsLbl.text = item.details
    }
}
