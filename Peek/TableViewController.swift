

import UIKit


class TableViewController: UITableViewController {
    

    
    var fixed: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        

        

    }
 
   
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row )"
  

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
           }
 
}

