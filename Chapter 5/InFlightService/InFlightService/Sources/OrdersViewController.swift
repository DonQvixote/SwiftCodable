import UIKit

public class OrdersViewController: UITableViewController {
    public var orders = [Order]()

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}

extension OrdersViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        var textString = ""
        for i in 0..<orders[indexPath.row].lineItems.count {
            textString += orders[indexPath.row].lineItems[i].item.name + ": " + String(orders[indexPath.row].lineItems[i].count) + " "
        }
        cell.textLabel?.text = textString
        cell.detailTextLabel?.text = "TotalPrice: " + String(orders[indexPath.row].totalPrice)
        return cell
    }
}

