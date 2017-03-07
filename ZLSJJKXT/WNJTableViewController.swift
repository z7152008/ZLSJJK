//
//  WNJTableViewController.swift
//  ZLSJJKXT
//
//  Created by 张亮 on 2017/3/5.
//  Copyright © 2017年 zhangliang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RappleProgressHUD

class WNJTableViewController: UITableViewController {
    var wnjArr = [wnj]()
    var uname:String?
    var upassword:String?
    
    let userDefaults = UserDefaults.standard

    //http://221.207.32.74:8880//zljkxt/m/wnj/sygk.action?staffAccount=sys&staffPass=1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "万能机"
        uname = userDefaults.string(forKey: "name")
        upassword = userDefaults.string(forKey: "password")
        getData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
       
    func getData(){
        RappleActivityIndicatorView.startAnimatingWithLabel("数据加载中...", attributes: RappleModernAttributes)
        let url = "http://221.207.32.74:8880//zljkxt/m/wnj/sygk.action?staffAccount=\(uname!)&staffPass=\(upassword!)"
        Alamofire.request(url).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let json =  JSON(value)
                    for (_,objecValue) in json{
                        let wnjvalue = objecValue.dictionaryObject! as Dictionary<String,Any>
                        self.wnjArr.append(wnj(wnjDic: wnjvalue))
                    }
                    self.tableView.reloadData()
                    RappleActivityIndicatorView.stopAnimating()
                }
                
                break
                
            case .failure(let error):
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wnjArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wnjCell", for: indexPath) as! WNJTableViewCell

        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.wnj_mc.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.wnj_sysj?.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.wnj_sylx.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.wnj_klqd.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            cell.wnj_mc.backgroundColor = UIColor.clear
            cell.wnj_klqd?.backgroundColor = UIColor.clear
            cell.wnj_sylx.backgroundColor = UIColor.clear
            cell.wnj_sysj.backgroundColor = UIColor.clear
        }
        

        
        // Configure the cell...
        cell.configureCells(wnj: wnjArr[indexPath.row])

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
        if segue.identifier == "showWnjInfo"{
            let wnjInfoView = segue.destination as! WnjInfoViewController
            let index = tableView.indexPathForSelectedRow
            wnjInfoView.wnj = wnjArr[index!.row]
        }
    }
    

}
