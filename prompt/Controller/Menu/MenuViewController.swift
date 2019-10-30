import UIKit
import Parchment

// This first thing we need to do is to create our own custom paging
// view and override the layout constraints. The default
// implementation positions the menu view above the page view
// controller, but we want to include a header view above the menu. We
// also create a layout constraint property that allows us to update
// the height of the header.



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

    private let dataSource = MenuModel()

  let Nav = NavView()
  let restaurantName = "Le Moulin La Fayette"

fileprivate var menuDataArray = [MenuItem]()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource.delegate = self
    
    dataSource.setDataWithResponse()
    
    
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
    
    if let images = menuDataArray[index].images, let headers = menuDataArray[index].headers {
    
     
    let viewController = MenuTableViewController(
      images: images,
      titles: headers,
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
    } else {
        return UIViewController()
    }
  }

  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: "\(menuDataArray[index].title ?? "Item")") as! T
  }

  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int{
    return menuDataArray.count
  }

}

extension MenuViewController: PagingViewControllerDelegate {


}

extension MenuViewController: UITableViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {

  }

}



extension MenuViewController: MenuModelDelegate {
    func didReceiveMenu(data: [MenuItem]) {
        menuDataArray = data
    }
}
