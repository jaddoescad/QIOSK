import UIKit
import Parchment

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    fileprivate let images: [UIImage]
    fileprivate let titles: [String]
    fileprivate let restaurantTitle: String
    var menuView = MenuView()
//    var MenuTableView = UITableView()
//    var menuTable = UITableView()

    private static let CellIdentifier = "CellIdentifier"
    init(images: [UIImage],titles: [String],restaurantTitle: String,  options: PagingOptions) {
      self.images = images
      self.titles = titles
      self.restaurantTitle = restaurantTitle
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(menuView)
//        var menuTable = UITableView()

//        let menuTable = menuView.tableView
        

        menuView.translatesAutoresizingMaskIntoConstraints = false

        menuView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true

        menuView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "contactCell")
        menuView.tableView.delegate = self
        menuView.tableView.dataSource = self

    }
    

    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! CustomTableViewCell
        cell.profileImageView.image = images[indexPath.item]
        cell.nameLabel.text = titles[indexPath.item]
        cell.TitleDetailedLabel.text = "The Moulins La Fayette Cheesecake is made from a tasty blend of cheese mousse and small fruits."
        cell.price.text = "$6.95"
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hell")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//
//class MenuView: UIView {
//    var tableView = UITableView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createSubviews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        createSubviews()
//    }
//
//    func createSubviews() {
//        // all the layout code from above
//        createTable()
//
//    }
//    func createTable() {
//
//        self.addSubview(tableView)
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = UITableView.automaticDimension
//        self.backgroundColor = .white
//    }
//}
//


class MenuView: UIView {
    var tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createTable()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func createTable() {

         self.addSubview(tableView)

         tableView.translatesAutoresizingMaskIntoConstraints = false

         tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
         tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
         tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
         tableView.rowHeight = UITableView.automaticDimension
         tableView.estimatedRowHeight = UITableView.automaticDimension
         self.backgroundColor = .white
        tableView.backgroundColor = .white
     }

}

