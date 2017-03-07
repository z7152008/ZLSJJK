//
//  YLJTableViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class YLJTableViewCell: UITableViewCell {
    @IBOutlet weak var ylj_mc: UILabel!
    @IBOutlet weak var ylj_sysj: UILabel!
    @IBOutlet weak var ylj_sylx: UILabel!
    @IBOutlet weak var ylj_qddbz: UILabel?
    var ylj_id:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCells(ylj:ylj){
         ylj_mc.text = ylj.ylj_mc
        ylj_sysj.text = ylj.sysj
        ylj_sylx.text = ylj.sylx
        
        if ylj.qddbz == 0{
            ylj_qddbz?.text = "-"
        }else{
            ylj_qddbz?.text = "\(ylj.qddbz)"
        }
           ylj_id = ylj.ylj_id
    }

}
