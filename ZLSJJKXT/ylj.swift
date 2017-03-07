//
//  ylj.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation

class ylj{
    private var _ylj_mc:String!
    private var _qddbz:Double!
    private var _sylx:String!
    private var _sysj:String!
    private var _ylj_id:String!
    var ylj_mc:String{
        if _ylj_mc == nil{
           _ylj_mc = "-"
        }
        return _ylj_mc
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
    var ylj_id:String{
        if _ylj_id == nil{
            _ylj_id = "-"
        }
        return _ylj_id
    }
    var qddbz:Double{
        if _qddbz == nil{
            _qddbz = 0
        }
        return _qddbz
    }
    
    init(yljDic:Dictionary<String,Any>) {
        self._ylj_mc = yljDic["ylj_mc"] as? String
        self._sysj = yljDic["sysj"] as? String
        self._sylx = yljDic["sylx"] as? String
        self._ylj_id = yljDic["ylj_id"] as? String
        self._qddbz = yljDic["qddbz"] as? Double
        
    }
    
    
}
