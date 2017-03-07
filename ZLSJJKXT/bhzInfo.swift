//
//  bysInfo.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation

class bhzInfo{
    private var _gcmc:String!
    private var _sgbw:String!
    private var _tdj:String!
    private var _scsl:Double!
    private var _scsj:String!
    private var _ylxq:[bhzcl]!
    var gcmc:String{
        if _gcmc == nil{
            _gcmc = "-"
        }
        return _gcmc
    }
    
    var sgbw:String{
        if _sgbw == nil{
            _sgbw = "-"
        }
        return _sgbw
    }
    var tdj:String{
        if _tdj == nil{
            _tdj = "-"
        }
        return _tdj
    }
    var scsj:String{
        if _scsj == nil{
            _scsj = "-"
        }
        return _scsj
    }
    
    var scsl:Double{
        if _scsl == nil{
            _scsl = 0
        }
        return _scsl
    }
    var ylxq:[bhzcl]{
        if _ylxq == nil{
            _ylxq = [bhzcl]()
        }
        return _ylxq
    }
}
