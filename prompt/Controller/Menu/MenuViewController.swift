import UIKit
import Parchment

// This first thing we need to do is to create our own custom paging
// view and override the layout constraints. The default
// implementation positions the menu view above the page view
// controller, but we want to include a header view above the menu. We
// also create a layout constraint property that allows us to update
// the height of the header.
struct ImageItem: PagingItem, Hashable, Comparable {
  let index: Int
  let title: String
  let headerImage: UIImage
  let headers: [String]
//  let description : String
//  let price: [String]
  let images: [UIImage]

  var hashValue: Int {
    return index.hashValue &+ title.hashValue
  }

  static func ==(lhs: ImageItem, rhs: ImageItem) -> Bool {
    return lhs.index == rhs.index && lhs.title == rhs.title
  }

  static func <(lhs: ImageItem, rhs: ImageItem) -> Bool {
    return lhs.index < rhs.index
  }
}

class CustomPagingView: PagingView {

    let NavView = UIView()
    let BackButton = UIButton()
    let NavRestaurantTitle = UILabel()
  override func setupConstraints() {
    
    pageView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false

    createNavBar()
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
      collectionView.topAnchor.constraint(equalTo: NavView.bottomAnchor),


      pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      pageView.topAnchor.constraint(equalTo: NavView.bottomAnchor)
    ])
  }
    func createNavBar() {
         addSubview(NavView)
         NavView.backgroundColor = UIColor(rgb: 0x365E7A)
         NavView.translatesAutoresizingMaskIntoConstraints = false
         NavView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
         NavView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         NavView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
         NavView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive  = true
         NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
     }
}

class NavView: UIView {
    let newView = UIImageView()
    let coverView = UIView()
    let titlerestaurant = UILabel()
    let NavView = UIView()
    let BackButton = UIButton()
    let NavRestaurantTitle = UILabel()
    var Cartbutton = UIButton()


    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        // all the layout code from above
        createNavBar()
    }
    
    func createNavBar() {
            addSubview(NavView)
            NavView.backgroundColor = UIColor(rgb: 0x365E7A)
            NavView.translatesAutoresizingMaskIntoConstraints = false
            NavView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            NavView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            NavView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive  = true
            NavView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive  = true
//            NavView.heightAnchor.constraint(equalToConstant: 64).isActive = true
            NavView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

            addBackButton()
            addTitle()
        }
        func addTitle() {
            NavView.addSubview(NavRestaurantTitle)
            NavRestaurantTitle.translatesAutoresizingMaskIntoConstraints = false
            NavRestaurantTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            NavRestaurantTitle.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: -10).isActive = true
            NavRestaurantTitle.font = UIFont(name: "AvenirNext-Medium", size: 17)
            NavRestaurantTitle.textColor = .white
        }
        
        func addBackButton() {
             NavView.addSubview(BackButton)
             BackButton.imageView?.contentMode = .scaleAspectFit
             BackButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: -40, bottom: 10, right: 20)
             BackButton.setImage(UIImage(named: "Back"), for: .normal)
             BackButton.translatesAutoresizingMaskIntoConstraints = false
             BackButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
             BackButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
             BackButton.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: 0).isActive = true
             BackButton.leftAnchor.constraint(equalTo: NavView.leftAnchor).isActive  = true
             BackButton.semanticContentAttribute = .forceLeftToRight

        }
    
    @objc func GoBack() {
        
    }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class CustomPagingViewController: PagingViewController<PagingIndexItem> {
  override func loadView() {
    view = CustomPagingView(
      options: options,
      collectionView: collectionView,
      pageView: pageViewController.view
    )
  }
}

class MenuViewController: UIViewController {

  private let pagingViewController = CustomPagingViewController()
var Cartbutton = UIButton()
var price = UILabel()


  let Nav = NavView()
  let restaurantName = "Le Moulin La Fayette"
  private let items = [
  ImageItem(
    index: 0,
    title: "Cake",
    headerImage: UIImage(named: "green-1")!,
    headers: [
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    ],

    images: [
      UIImage(named: "green-1")!,
      UIImage(named: "green-2")!,
      UIImage(named: "green-3")!,
      UIImage(named: "green-4")!,
    ]
    ),
  ImageItem(
    index: 0,
    title: "Sweets",
    headerImage: UIImage(named: "green-1")!,
    headers: [
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    ],

    images: [
      UIImage(named: "green-1")!,
      UIImage(named: "green-2")!,
      UIImage(named: "green-3")!,
      UIImage(named: "green-4")!,
    ]),
  ImageItem(
    index: 0,
    title: "Dessert",
    headerImage: UIImage(named: "green-1")!,
    headers: [
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    "Spicy Latte",
    ],

    images: [
      UIImage(named: "green-1")!,
      UIImage(named: "green-2")!,
      UIImage(named: "green-3")!,
      UIImage(named: "green-4")!,
    ]),
  ]
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    Nav.BackButton.addTarget(self, action: #selector(GoBack), for: .touchUpInside)

    price.text = "$17.96"

    // Add the paging view controller as a child view controller.
    addChild(pagingViewController)
    view.addSubview(pagingViewController.view)
    pagingViewController.didMove(toParent: self)
    // Customize the menu styling.
    pagingViewController.selectedTextColor = UIColor(rgb:0x365E7A)
    pagingViewController.textColor = .gray
    pagingViewController.indicatorColor = UIColor(rgb:0x365E7A)
    pagingViewController.indicatorOptions = .visible(
      height: 1,
      zIndex: Int.max,
      spacing: .zero,
      insets: .zero
    )


    pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

    ])
    
    // Contrain the paging view to all edges.
    self.view.addSubview(Nav)
    Nav.backgroundColor = UIColor(rgb: 0x365E7A)
    Nav.translatesAutoresizingMaskIntoConstraints = false
    Nav.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    Nav.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    Nav.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive  = true
    Nav.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive  = true
    Nav.heightAnchor.constraint(equalToConstant: 64).isActive = true
    
    Nav.NavRestaurantTitle.text = "Les Moulins La Fayette"
    addCartButton()
    // Set our data source and delegate.
    pagingViewController.dataSource = self
    pagingViewController.delegate = self
    
    
  }
    func addCartButton() {
        self.view.addSubview(Cartbutton)
        Cartbutton.addSubview(price)
        

        Cartbutton.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false

        Cartbutton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        Cartbutton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        Cartbutton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        Cartbutton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        Cartbutton.backgroundColor = UIColor(rgb: 0x365E7A)
        Cartbutton.setTitle("View Cart", for: .normal)
        Cartbutton.titleLabel?.font =  UIFont(name: "AvenirNext-Medium", size: 17)
        Cartbutton.addTarget(self, action: #selector(AddToCartAction), for: .touchUpInside)
        

        price.trailingAnchor.constraint(equalTo: Cartbutton.trailingAnchor, constant: -15).isActive = true
        price.centerYAnchor.constraint(equalTo: Cartbutton.centerYAnchor, constant: 0).isActive = true
        
        price.font = UIFont(name: "AvenirNext-Regular", size: 15)


        
    }
    
    @objc func AddToCartAction() {
    }
    
    @objc func GoBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MenuViewController: PagingViewControllerDataSource {

  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
    let viewController = MenuTableViewController(
      images: items[index].images,
      titles: items[index].headers,
      restaurantTitle: restaurantName,
      options: pagingViewController.options
    )
   
    let menuHeight = pagingViewController.options.menuHeight
    let insets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 60, right: 0)
    
//    print(viewController.menuView.tableView)
    viewController.menuView.tableView.contentInset = insets
    viewController.menuView.tableView.scrollIndicatorInsets = insets
    // Set automatic dimensions for row height

    return viewController
  }

  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: "\(items[index].title)") as! T
  }

  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
    return items.count
  }

}

extension MenuViewController: PagingViewControllerDelegate {


}

extension MenuViewController: UITableViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {

  }

}

