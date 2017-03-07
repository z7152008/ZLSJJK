
//
//  wnj.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation

class wnj{
    private var _wnj_mc:String!
    private var _klqd:Double!
    private var _sylx:String!
    private var _sysj:String!
    private var _wnj_id:String!
    
    var wnj_mc:String{
        if _wnj_mc == nil{
            _wnj_mc = "-"
        }
        return _wnj_mc
    }
    var klqd:Double{
        if _klqd == nil{
            _klqd = 0
        }
        return _klqd
    }
    var sylx:String{
        if _sylx == nil{
            _sylx = "-"
        }
        return _sylx
    }
    var sysj:String{
        if _sysj == nil{
            _sysj = "-"
        }
        return _sysj
    }
    var wnj_id:String{
        if _wnj_id == nil{
            _wnj_id = "-"
        }
        return _wnj_id
    }
    
    init(wnjDic:Dictionary<String,Any>) {
        self._wnj_mc = wnjDic["wnj_mc"] as? String
        self._sylx = wnjDic["sylx"] as? String
        self._sysj = wnjDic["sysj"] as? String
        self._wnj_id = wnjDic["wnj_id"] as? String
        self._klqd = wnjDic["Klqd"] as? Double
    }
}
