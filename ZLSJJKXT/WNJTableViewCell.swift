//
//  WNJTableViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class WNJTableViewCell: UITableViewCell {
    @IBOutlet weak var wnj_mc: UILabel!
    @IBOutlet weak var wnj_sysj: UILabel!
    @IBOutlet weak var wnj_sylx: UILabel!
    @IBOutlet weak var wnj_klqd: UILabel!
     var wnj_id:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCells(wnj:wnj){
        wnj_id = wnj.wnj_id
        wnj_mc.text = wnj.wnj_mc
        wnj_sysj.text = wnj.sysj
        wnj_sylx.text = wnj.sylx
        if wnj.klqd == 0{
            wnj_klqd.text = "-"
        }else{
            wnj_klqd.text = "\(wnj_klqd)"
        }
    }

}
