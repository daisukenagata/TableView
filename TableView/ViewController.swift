//
//  ViewController.swift
//  TableView
//
//  Created by 永田大祐 on 2020/12/03.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    private let tex = ["1",
                       "22",
                       "333",
                       "444444444444444444444444444444444444444444",
                       "55555",
                       "666666",
                       "7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777",
                       "8888888888",
                       "999999999999",
                       "10"]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        cell.tableLabel.text = tex[indexPath.row]
        cell.tableLabel.sizeToFit()
        
        cell.backLabel.text = tex[indexPath.row]
        cell.backLabel.sizeToFit()
        cell.backLabel.textColor = .clear

        table.rowHeight = cell.tableLabel.frame.size.height >= 44 ? cell.tableLabel.frame.size.height : 44
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
