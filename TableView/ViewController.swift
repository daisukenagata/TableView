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
                       "2",
                       "333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333433333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333334",
                       "444444444444444444444444444444444444444444",
                       "5",
                       "6",
                       "7",
                       "8",
                       "9",
                       "10"]

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 44
    }

    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        cell.tableLabel.text = tex[indexPath.row]
        cell.tableLabel.sizeToFit()
        table.rowHeight = cell.tableLabel.frame.size.height >= 44 ? cell.tableLabel.frame.size.height : 44
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
