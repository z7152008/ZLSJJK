//
//  UIViewExtension.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit

extension UIView{
    //阴影大小
    @IBInspectable var shadowOffset:CGSize{
        get{
            return layer.shadowOffset
        }set{
            layer.shadowOffset = newValue
        }
    }
    //隐形透明度
    @IBInspectable var shadowOpcity:Float{
        get{
            return layer.shadowOpacity
        }set{
            layer.shadowOpacity = newValue
        }
    }
    //阴影颜色
    @IBInspectable var shadowColor:UIColor?{
        get{
            return  UIColor(cgColor: layer.shadowColor!)
            
        }
        set{
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    //圆角设置
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return  layer.cornerRadius
        }set{
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
