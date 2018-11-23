//
//  ViewController.swift
//  AsyncCalls
//
//  Created by Zabeehullah Qayumi on 11/22/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    let dispatchGroup = DispatchGroup()
    
    var arrOfUsers = [String]()
    let groupA = ["User1"]
    let groupB = ["User2"]
    let groupC = ["User3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func run(after second: Int, completion: @escaping() -> Void){
        let deadline = DispatchTime.now() + .seconds(second)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func aDownload(){
        dispatchGroup.enter()
        run(after: 1) {
            self.arrOfUsers.append(contentsOf: self.groupA)
            self.dispatchGroup.leave()
        }
        
    }
    func bDownlaod(){
        dispatchGroup.enter()
        run(after: 1) {
            self.arrOfUsers.append(contentsOf: self.groupB)
            self.dispatchGroup.leave()


            
        }
    }
    func cDownload(){
        dispatchGroup.enter()
        run(after: 1) {
            self.arrOfUsers.append(contentsOf: self.groupC)
            self.dispatchGroup.leave()


        }
        
    }
    
    @IBAction func dPressed(_ sender: Any) {
        aDownload()
        bDownlaod()
        cDownload()
        dispatchGroup.notify(queue: .main) {
            self.displayScreen()
        }
        
        
    }
    func displayScreen(){
        tableView.reloadData()
    }
    
    
}


extension TableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfUsers.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrOfUsers[indexPath.row]
        return cell
    }
}

