//
//  Data+Formatter.swift
//  TestRealm
//
//  Created by 张亮 on 2017/2/22.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import Foundation



extension Date{
    public static func dateWithString(_ dateStr:String,format:String,local:Locale) -> Date?{
        
        let df = DateFormatter()
        df.locale = local
        df.timeZone = TimeZone.current
        df.dateFormat = format
        if let date = df.date(from: dateStr){
            return date
        }
        return nil
    }
    
    public static func stringWithDate(_ date:Date,format:String,local:Locale)->String{
        let df = DateFormatter()
        df.locale  = local
        df.timeZone = TimeZone.current
        df.dateFormat = format
        return df.string(from: date)
    }
}
