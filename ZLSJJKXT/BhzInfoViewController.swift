//
//  BhzInfoViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class BhzInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var gcmc: UILabel!
    @IBOutlet weak var sgbw: UILabel!
    @IBOutlet weak var tdj: UILabel!
    @IBOutlet weak var scjl: UILabel!
    @IBOutlet weak var scsj: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentSelected: UISegmentedControl!

    var bhz:bhz?
    var bhz_id:String? = nil
    var bhz_info:bhzInfo?
    //http://221.207.32.74:8880/zljkxt/m/snbhz/ylsj.action?sbid= fdcc663256e045900156e0497f8d0006&rownum=1&flag=0
    var currentRownum = 1

    let userDefaults = UserDefaults.standard
    var bhzclInfo:[bhzcl] = [bhzcl]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = bhz?.bhz_mc
        bhz_id = bhz?.bhz_id
        getData(1, flag: 0)
        segmentSelected.selectedSegmentIndex = 0

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: 显示当前页数
    func addLabel(_ currentP:Int,flag:Int){
        
        let label = UILabel(frame: CGRect(x:(self.view.frame.width - 150)/2, y: self.view.frame.height - 70, width: 150, height: 20))
        if flag == 0{
          label.text = "当前为用量第\(currentP)行"
        }else{
          label.text = "当前为超标第\(currentP)行"
        }
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor =  .white
        label.backgroundColor = .black
        self.view.addSubview(label)
        UIView.animate(withDuration: 2.0, animations: {
            label.alpha = 0
        }, completion: { (_) in
            label.removeFromSuperview()
        })
        
    }

    
    @IBAction func previousPage(_ sender: UIButton) {
        if segmentSelected.selectedSegmentIndex == 0{
            currentRownum = userDefaults.integer(forKey: "bhzylrownum")
            
            if currentRownum <= 1{
                addLabel(1, flag: 0)
            }else{
              addLabel((currentRownum - 1), flag: 0)
              getData(currentRownum - 1, flag: 0)
            }

        }else{
            
            currentRownum = userDefaults.integer(forKey: "bhzcbrownum")
            if currentRownum <= 1{
                addLabel(1, flag: 1)
            }else{
                addLabel((currentRownum - 1), flag: 1)
                getData(currentRownum - 1, flag: 1)
            }
        }        
    }
    @IBAction func nextPage(_ sender: UIButton) {
        if segmentSelected.selectedSegmentIndex == 0{
            addLabel(currentRownum + 1, flag: 0)
            currentRownum = userDefaults.integer(forKey: "bhzylrownum")
            getData(currentRownum + 1, flag: 0)
        }else{
            addLabel(currentRownum + 1, flag: 1)
            currentRownum = userDefaults.integer(forKey: "bhzcbrownum")
            getData(currentRownum + 1, flag: 1)
        }
    }
    @IBAction func action_segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            addLabel(1, flag: 0)
            getData(1, flag: 0)
            segmentSelected.selectedSegmentIndex = 0
        }else{
            addLabel(1, flag: 1)
            getData(1, flag: 1)
            segmentSelected.selectedSegmentIndex = 1
        }
    }
    
    //MARK:获取数据
    func getData(_ rownum:Int,flag:Int){
        self.bhzclInfo.removeAll()
        RappleActivityIndicatorView.startAnimatingWithLabel("数据加载中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880/zljkxt/m/snbhz/ylsj.action?sbid=\(bhz!.bhz_id)&rownum=\(rownum)&flag=\(flag)"
        if flag == 0{
            userDefaults.set(rownum, forKey: "bhzylrownum")
        }else{
            userDefaults.set(rownum, forKey: "bhzcbrownum")
        }
        print(userDefaults.set(rownum, forKey: "bhzylrownum"))
        print(url)
        Alamofire.request(url).validate().responseJSON { (respnse) in
            switch respnse.result{
            case .success:
                if let value = respnse.result.value{
                    let json = JSON(value)
                    self.gcmc.text = json["gcmc"].stringValue
                    self.sgbw.text = json["sgbw"].stringValue
                    self.tdj.text = json["tdj"].stringValue
                    self.scsj.text = json["scsj"].stringValue
                    self.scjl.text = "\(json["scjl"].doubleValue)"
                    for (_,objValue) in json["ylxq"]{
                        let bhzclValue = objValue.dictionaryObject! as Dictionary<String,Any>
                        self.bhzclInfo.append(bhzcl(bhzclDic: bhzclValue))
                    }
                    self.tableview.reloadData()
                    RappleActivityIndicatorView.stopAnimating()
                    break
                }
            case .failure(let error):
                self.gcmc.text = "-"
                self.sgbw.text = "-"
                self.tdj.text = "-"
                self.scsj.text = "-"
                self.scjl.text = "-"
                RappleActivityIndicatorView.stopAnimating()
                print(error)
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bhzclInfo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bhzInfoCell", for: indexPath) as! BhzInfoTableViewCell
        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.yl.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.pf.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.sjyl.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.wc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            cell.yl.backgroundColor = UIColor.clear
            cell.pf.backgroundColor = UIColor.clear
            cell.sjyl.backgroundColor = UIColor.clear
            cell.wc.backgroundColor = UIColor.clear
        }
        

        
        cell.configureCells(bhzcl: bhzclInfo[indexPath.row])
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
