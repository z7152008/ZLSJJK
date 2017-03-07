//
//  BhzInfoTableViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class BhzInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var yl: UILabel!
    @IBOutlet weak var pf: UILabel!
    @IBOutlet weak var sjyl: UILabel!
    @IBOutlet weak var wc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCells(bhzcl:bhzcl){
        yl.text = "\(bhzcl.clmc)"
        pf.text = "\(bhzcl.pfyl)"
        sjyl.text = "\(bhzcl.sjyl)"
        wc.text = "\(bhzcl.ylwc)"
    }

}
