//
//  ViewController.swift
//  DummyJSON
//
//  Created by Furkan Beyhan on 1.03.2019.
//  Copyright © 2019 Furkan Beyhan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var dataList = [Items]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://jsonplaceholder.typicode.com/todos").responseJSON { (responseData) -> Void in
            
            if ((responseData.result.value) != nil){
                
                
                let decoder = JSONDecoder()
                let response = try! decoder.decode([Items].self, from: responseData.data!)
                
//                let response = JSON(responseData.data!)
//
//                for res in response.arrayValue {
//                    let i = Items()
//                    i.title = res["title"].stringValue
//                    i.complete = res["completed"].boolValue
//                    self.dataList.append(i)
//                }
                self.dataList = response
                self.tableView.reloadData()
                print(response)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        let item = dataList[indexPath.row]
        cell.textLabel?.text = item.title
        cell.textLabel?.textColor = UIColor.white
        
        if item.completed!{
            cell.backgroundColor = UIColor.black
        }else {
            cell.backgroundColor = UIColor.orange
        }
        return cell
    }
    
}
