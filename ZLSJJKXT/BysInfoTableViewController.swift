//
//  BysInfoTableViewController.swift
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
class BysInfoTableViewController: UITableViewController,GTMRefreshHeaderDelegate,GTMLoadMoreFooterDelegate {
    
    @IBOutlet weak var previousBtnTitle: UIButton!
    var bysInfo:bys!
    var currentPage = 1
    var bysInfoArr:[bys] = [bys]()
    var rows = 12
    
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = bysInfo.bys_mc
        print(bysInfo.bys_id)
        requestData(page: currentPage)
        self.tableView.gtm_addLoadMoreFooterView(delegate: self)
        self.tableView.gtm_addRefreshHeaderView(delegate: self)
        if userDefaults.integer(forKey: "bysInfocurrentPage") == 1{
            previousBtnTitle.titleLabel?.text = "第一页"
        }
    }
    
    // MARK: - GTMRefreshHeaderDelegate
    func refresh() {
        currentPage =  userDefaults.integer(forKey: "bysInfocurrentPage")
        print(currentPage)
        if currentPage > 1 {
            requestData(page: currentPage - 1)
            self.tableView.endRefreshing(isSuccess: true)
        }else{
            addLabel(currentP: currentPage)
            self.tableView.endRefreshing(isSuccess: true)
        }
    }
    
    
    // MARK: - GTMLoadMoreFooterDelegate
    func loadMore() {
        
        requestData(page: userDefaults.integer(forKey: "bysInfocurrentPage") + 1)
        self.tableView.endRefreshing(isSuccess: true) //加载完成
    }
    
    //MARK: 显示当前页数
    func addLabel(currentP:Int){
        
        let label = UILabel(frame: CGRect(x:(self.view.frame.width - 100)/2, y: self.view.frame.height - 100, width: 100, height: 20))
        label.text = "当前第\(currentP)页"
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

    //MARK 请求数据
    func requestData(page:Int){
        self.userDefaults.set(page, forKey: "bysInfocurrentPage")
        addLabel(currentP: userDefaults.integer(forKey: "bysInfocurrentPage"))
        //print( userDefaults.integer(forKey: "bysInfocurrentPage"))

        RappleActivityIndicatorView.startAnimatingWithLabel("数据加载中...", attributes: RappleModernAttributes)
        self.bysInfoArr.removeAll()
        let url = "http://221.207.32.74:8880/zljkxt/m/bys/jksj.action?sbid=\(bysInfo.bys_id)&page=\(page)&rows=\(rows)"
       // print(url)
        Alamofire.request(url).validate().responseJSON { (response) in
            if let value = response.result.value{
               let json = JSON(value)
                for(_,ObjectValue) in json{
                    let bysValue = ObjectValue.dictionaryObject! as Dictionary<String,Any>
                    self.bysInfoArr.append(bys(bysDict: bysValue))
                    //print(self.bysInfoArr)
                }
                self.tableView.reloadData()
                RappleActivityIndicatorView.stopAnimating()
            }
        }
    }
    
    
    @IBAction func previousPage(_ sender: UIButton) {
        currentPage =  userDefaults.integer(forKey: "bysInfocurrentPage")
        print(currentPage)
        if currentPage > 1 {
            requestData(page: currentPage - 1)
            self.tableView.endRefreshing(isSuccess: true)
        }else{
            addLabel(currentP: currentPage)
            self.tableView.endRefreshing(isSuccess: true)
        }
    }
    @IBAction func nextPage(_ sender: UIButton) {
        requestData(page: userDefaults.integer(forKey: "bysInfocurrentPage") + 1)
        self.tableView.endRefreshing(isSuccess: true) //加载完成
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
        return bysInfoArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bysInfoCell", for: indexPath) as! BysInfoTableViewCell
        
        //设置背景色
        if (2 + indexPath.row) % 2 == 0{
            
            cell.bys_sj.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bys_wd.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
            cell.bys_sd.backgroundColor = UIColor(displayP3Red: 223/255, green: 223/255, blue: 221/255, alpha: 1)
        }else{
            
            cell.bys_sj.backgroundColor = UIColor.clear
            cell.bys_wd.backgroundColor = UIColor.clear
            cell.bys_sd.backgroundColor = UIColor.clear
        }

        
        cell.configureCell(bys: bysInfoArr[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navH = self.navigationController?.navigationBar.frame.size.height
        let statusBH = UIApplication.shared.statusBarFrame.size.height
        let cellH = (UIScreen.main.bounds.size.height - navH! - 44 - 44 - statusBH) / CGFloat(rows)
        print(cellH)
        return cellH
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
