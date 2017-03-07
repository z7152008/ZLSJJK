//
//  MainCollectionViewCell.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/1.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

//extension UIImageView{
//    //@IBInspectable storyboard渲染
//    @IBInspectable var cornerRadius:CGFloat{
//        get{
//            return layer.cornerRadius
//        }
//        set{
//            layer.cornerRadius = newValue
//            layer.masksToBounds = (newValue > 0)
//        }
//    }
//}
