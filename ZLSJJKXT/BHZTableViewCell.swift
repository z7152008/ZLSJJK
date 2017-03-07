//
//  BHZTableViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class BHZTableViewCell: UITableViewCell {

    @IBOutlet weak var bhz_cbpc: UILabel!
    @IBOutlet weak var bhz_cbcl: UILabel!
    @IBOutlet weak var bhz_jrcl: UILabel!
    @IBOutlet weak var bhz_mc: UILabel!
    var bhz_id:String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCells(bhz:bhz){
        bhz_mc.text = "\(bhz.bhz_mc)"
        bhz_id = bhz.bhz_id
        let cbcl = bhz.cbcl
        if cbcl == 0{
            bhz_cbcl.text = "-"
        }else{
            bhz_cbcl.text = "\(cbcl)"
        }
        let cbpc = bhz.cbpc
        if cbpc == 0{
            bhz_cbpc.text = "-"
        }else{
            bhz_cbpc.text = "\(cbpc)"
        }
        let jrcl = bhz.jrcl
        if jrcl == 0{
            bhz_jrcl.text = "-"
        }else{
            bhz_jrcl.text = "\(jrcl)"
        }
    }

}
