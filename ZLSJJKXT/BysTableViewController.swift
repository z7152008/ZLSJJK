//
//  BysTableViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/4.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD
import GTMRefresh

class BysTableViewController: UITableViewController,GTMRefreshHeaderDelegate{

    var bysArr:[bys] = [bys]()
    
    let userDefaults = UserDefaults.standard
    
        override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "标准养护室"
        getData()
        self.tableView.gtm_addRefreshHeaderView(delegate: self)
    }
    //MARK 刷新数据
    func refresh() {
        getData()
        self.tableView.endRefreshing(isSuccess: true)
    }
    
   
    
    //MARK：获取数据
    func getData(){
        RappleActivityIndicatorView.startAnimatingWithLabel("正在加载数据...", attributes: RappleModernAttributes)
        let uname = userDefaults.string(forKey: "name")
        let password = userDefaults.string(forKey: "password")
        let url = "http://221.207.32.74:8880/zljkxt/m/bys/jkgk.action?staffAccount=\(uname!)&staffPass=\(password!)"
        self.bysArr.removeAll()
        Alamofire.request(url).validate().responseJSON { (response) in
            switch (response.result){
            case .success:
                
                if let value = response.result.value{
                    let json = JSON(value)
                    for (_,objvalue) in json{
                        
                        let bys_value = objvalue.dictionaryObject! as Dictionary<String,Any>
                        self.bysArr.append(bys(bysDict: bys_value))
                    }
                    RappleActivityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                RappleActivityIndicatorView.stopAnimating()
                 print("\n\nAuth request failed with error:\n \(error)")
                break
            }
            
        }
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bysArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bysCell", for: indexPath) as! BysTableViewCell

        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.bys_mc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bys_sj.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bys_wd.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bys_sd.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            cell.bys_mc.backgroundColor = UIColor.clear
            cell.bys_sj.backgroundColor = UIColor.clear
            cell.bys_wd.backgroundColor = UIColor.clear
            cell.bys_sd.backgroundColor = UIColor.clear
        }

        
        cell.configureCell(bys: bysArr[indexPath.row])
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showBysInfo"{
            let bysinfoView = segue.destination as! BysInfoTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            bysinfoView.bysInfo = bysArr[indexPath.row]
        }
    }
    

}
