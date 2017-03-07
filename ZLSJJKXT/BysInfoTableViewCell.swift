//
//  BysInfoTableViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/4.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class BysInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var bys_sj: UILabel!
    @IBOutlet weak var bys_wd: UILabel!
    
    @IBOutlet weak var bys_sd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(bys:bys){
        bys_sj.text = "\(bys.bys_cjsj)"
        let wd = bys.bys_wd
        if wd > 22  || (wd < 18 && wd > 0){
            bys_wd.textColor = .red
            bys_wd.text = "\(bys.bys_wd)"
        }else if wd == 0.0{
            bys_wd.text = "-"
            bys_wd.textColor = .black
        }else{
            bys_wd.text = "\(bys.bys_wd)"
            bys_wd.textColor = .black
        }
        let sd = bys.bys_sd
        if sd < 95 && sd > 0{
            bys_sd.textColor = .red
            bys_sd.text = "\(bys.bys_sd)"
        }else if sd == 0{
            bys_sd.text = "-"
            bys_sd.textColor = .black
        }
        else{
            bys_sd.textColor = .black
            bys_sd.text = "\(bys.bys_sd)"
        }
    }


}
