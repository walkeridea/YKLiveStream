//
//  LivesTableViewController.swift
//  YKLiveStream
//
//  Created by walker on 2017/10/19.
//  Copyright © 2017年 walker. All rights reserved.
//

import UIKit
import Just
import Kingfisher

class LivesTableViewController: UITableViewController {
    
    let livelistUrl="http://116.211.167.106/api/live/infos?id=1508426191489746%2C1508426683286581&multiaddr=1&lc=0000000000000074&cc=TG0001&cv=IK5.0.05_Iphone&proto=8&idfa=00000000-0000-0000-0000-000000000000&idfv=EFF61679-E5E5-42D7-A409-7C273E5AA1D0&devi=f9246265410eb7ee2060a48603a8f174ad49290c&osversion=ios_11.000000&ua=iPhone9_1&imei=&imsi=&uid=595946021&sid=20xZaHWkYjNi51T2uLQ0xi0we3CTYzqzi19mWOJ9yUi18ci2Oi2PXuU&conn=wifi&mtid=c55701df254db3e38a6ea42a698a85ec&mtxid=a8574efd16cd&logid=265,214,226,231&s_sg=f02fb85b6c2c893bb2a90f7b3b7dc39d&s_sc=100&s_st=1508426567"
    
    var list:[YKCell]=[]

    override func viewDidLoad() {
        super.viewDidLoad()

        loadlist()
        
        // 下拉刷新
        self.refreshControl=UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadlist), for: .valueChanged)
    }
    
    @objc func loadlist(){
        Just.post(livelistUrl) { (result) in
            guard let json=result.json as? NSDictionary else{
                return
            }
            
            let lives=YKStream(fromDictionary: json).lives!
            self.list=lives.map({ (live) -> YKCell in
                 return YKCell(portrait: live.creator.portrait, nick: live.creator.nick, location: live.creator.location, viewers: live.onlineUsers, url: live.streamAddr)
            })
            
            dump(self.list)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LiveTableViewCell
        let live=list[indexPath.row]
        cell.labelAddr.text=live.location
        cell.labelNick.text=live.nick
        cell.labelViews.text="\(live.viewers)"
        
        let imgUrl=URL(string: live.portrait)
        cell.imgPor.kf.setImage(with: imgUrl)
        cell.imgBigPor.kf.setImage(with: imgUrl)
        return cell
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        let dest=segue.destination as! ViewController
        dest.live=list[(tableView.indexPathForSelectedRow?.row)!]
    }
    

}
