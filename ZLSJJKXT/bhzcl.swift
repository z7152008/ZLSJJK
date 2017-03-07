//
//  bhzcl.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation

class bhzcl{
    private var _clmc:String!
    private var _sjyl:String!
    private var _pfyl:String!
    private var _ylwc:String!
    
    var clmc:String{
        if _clmc == nil{
            _clmc = "-"
        }
        return _clmc
    }
    var sjyl:String{
        if _sjyl == nil{
            _sjyl = "-"
        }
        return _sjyl
    }
    var pfyl:String{
        if _pfyl == nil{
            _pfyl = "-"
        }
        return _pfyl
    }
    var ylwc:String{
        if _ylwc == nil{
            _ylwc = "-"
        }
        return _ylwc
    }
    
    init(bhzclDic:Dictionary<String,Any>) {
        self._clmc = bhzclDic["clmc"] as! String
        self._pfyl = bhzclDic["pfyl"] as! String
        self._sjyl = bhzclDic["sjyl"] as! String
        self._ylwc = bhzclDic["ylwc"] as! String
    }
    
}
