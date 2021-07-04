//
//  ViewController.swift
//  TableView
//
//  Created by 永田大祐 on 2020/12/03.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var table: UITableView!
    private var textField = UITextField()
    private var rectHeight: CGFloat = 0
    private var tex = ["1",
                       "22",
                       "333",
                       "444444444444444444444444444444444444444444",
                       "55555",
                       "666666",
                       "7777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777",
                       "8888888888",
                       "999999999999",
                       "10"]
    var addBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        configureObserver()

        title = "Home"
        addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClick))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        textField.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        textField.delegate = self
        view.addSubview(textField)
        textField.becomeFirstResponder()
    }

    @objc func onClick() {
        tex.insert("0", at: 0)
        DispatchQueue.main.async { [self] in
            tex.append("123")
        }
        reloadLogic(tableView: table, indexPath: table.getIndexPathFor(tableView: table)!)
    }

    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardWillShowNotification(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        rectHeight = rect.height
        UIView.performWithoutAnimation {
            table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: rect.height, right: 0)
            table.setNeedsDisplay()
        }
    }

    @objc private func handleKeyboardWillHideNotification() {
        UIView.performWithoutAnimation {
            table.contentInset = .zero
            table.setNeedsDisplay()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        cell.tableLabel.text = tex[indexPath.row]
        cell.tableLabel.sizeToFit()
        
        cell.backLabel.text = tex[indexPath.row]
        cell.backLabel.sizeToFit()
        cell.backLabel.textColor = .clear

        table.rowHeight = cell.tableLabel.frame.size.height >= 100 ? cell.tableLabel.frame.size.height : 100
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tex.count
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeAction = UIContextualAction(style: .normal,
                                              title: "Delete",
                                              handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
                                                self.tex.remove(at: indexPath.row)
                                                self.deleatedLogic(tableView: tableView, indexPath: indexPath)
                                                success(true)
                                              })
        removeAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [removeAction])
    }

    private func deleatedLogic(tableView: UITableView, indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath] , with: .top)
        UIView.performWithoutAnimation {
            tableView.endUpdates()
        }
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: rectHeight, right: 0)
        }
    }

    private func reloadLogic(tableView: UITableView, indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath] , with: .fade)
        UIView.performWithoutAnimation {
            tableView.endUpdates()
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: rectHeight, right: 0)
            }
        }
    }
}

extension UITableView {
    func getIndexPathFor(tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(tableView.bounds.origin, from: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
}
