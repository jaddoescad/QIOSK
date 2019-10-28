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


  override func setupConstraints() {
    pageView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false


    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: options.menuHeight),
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),


      pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      pageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      pageView.topAnchor.constraint(equalTo: topAnchor)
    ])
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

    // Contrain the paging view to all edges.
    pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),

    ])

    // Set our data source and delegate.
    pagingViewController.dataSource = self
    pagingViewController.delegate = self
    
    
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
    let insets = UIEdgeInsets(top: menuHeight, left: 0, bottom: 0, right: 0)
    
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
