//
//  bys.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/2.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation

class bys{
    private var _bys_id:String!
    private var _bys_mc:String!
    private var _bys_cjsj:String!
    private var _bys_wd:Double!
    private var _bys_sd:Double!
    
    var bys_id:String{
        if _bys_id == nil{
            _bys_id = "-"
        }
        return _bys_id
    }
    var bys_mc:String{
        if _bys_mc == nil{
            _bys_mc = "-"
        }
        return _bys_mc
    }
    var bys_cjsj:String{
        if _bys_cjsj == nil{
            _bys_cjsj = "-"
        }
        return _bys_cjsj
    }
    var bys_wd:Double{
        if _bys_wd == nil{
            _bys_wd = 0
        }
        return _bys_wd
    }
    var bys_sd:Double{
        if _bys_sd == nil{
            _bys_sd = 0
        }
        return _bys_sd
    }
    
    init(bysDict:Dictionary<String,Any>){
        self._bys_id = bysDict["bys_id"] as? String
        self._bys_mc = bysDict["bys_mc"] as? String
        self._bys_cjsj = bysDict["cjsj"] as? String
        self._bys_wd = bysDict["wd"] as? Double
        self._bys_sd = bysDict["sd"] as? Double
    }
}
