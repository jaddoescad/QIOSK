import UIKit
import Parchment

class MenuTableViewController: UITableViewController {
    fileprivate let images: [UIImage]
    fileprivate let titles: [String]
    fileprivate let restaurantTitle: String

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
//        self.navigationItem.title = "Your Title Here"

    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "contactCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.view.backgroundColor = .white
        
    }

    // UITableViewAutomaticDimension calculates height of label contents/text
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! CustomTableViewCell
        cell.profileImageView.image = images[indexPath.item]
        cell.nameLabel.text = titles[indexPath.item]
        cell.TitleDetailedLabel.text = "The Moulins La Fayette Cheesecake is made from a tasty blend of cheese mousse and small fruits."
        cell.price.text = "$6.95"
        cell.backgroundColor = .white
        cell.selectionStyle = .none

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hell")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ItemViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
