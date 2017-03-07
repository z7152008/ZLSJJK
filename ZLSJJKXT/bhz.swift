//
//  bhz.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation


class bhz{
    private var _bhz_mc:String!
    private var _jrcl:Double!
    private var _cbcl:Double!
    private var _cbpc:Double!
    private var _bhz_id:String!
    
    var bhz_mc:String{
        if _bhz_mc == nil{
             _bhz_mc = "-"
        }
        return _bhz_mc
    }
    var jrcl:Double{
        if _jrcl == nil{
            _jrcl = 0
        }
        return _jrcl
    }
    var cbcl:Double{
        if _cbcl == nil{
            _cbcl = 0
        }
        return _cbcl
    }
    var cbpc:Double{
        if _cbpc == nil{
            _cbpc = 0
        }
        return _cbpc
    }
    var bhz_id:String{
        if _bhz_id == nil{
            _bhz_id = "-"
        }
        return _bhz_id
    }
    
    init(bhzDict:Dictionary<String,Any>) {
        self._bhz_mc = bhzDict["bhz_mc"] as! String
        self._jrcl = bhzDict["jrcl"] as! Double
        self._cbpc = bhzDict["cbpc"] as! Double
        self._cbcl = bhzDict["cbcl"] as! Double
        self._bhz_id = bhzDict["bhz_id"] as! String
    }
}
