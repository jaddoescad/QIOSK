import UIKit
import MXParallaxHeader

final class HeaderViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var headerView = HeaderView()
    var RestaurantName = "Les Moulins La Fayette"
    
    var navAlpha = CGFloat()
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.layer.shadowColor = UIColor.black.cgColor
            titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
            titleLabel.layer.shadowOpacity = 0.3
            titleLabel.layer.shadowRadius = 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = headerView
        headerView.NavRestaurantTitle.text = RestaurantName
        headerView.titlerestaurant.text = RestaurantName
        headerView.BackButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        headerView.newView.image = UIImage(named: "photo2")
        parallaxHeader?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        headerView.NavView.backgroundColor = UIColor(rgb: 0x365E7A).withAlphaComponent(navAlpha)
        headerView.NavRestaurantTitle.alpha = navAlpha
    }
}

extension HeaderViewController: MXParallaxHeaderDelegate {
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        let alpha = 1 - min(1, parallaxHeader.progress)
        navAlpha = alpha
        headerView.NavView.backgroundColor = UIColor(rgb: 0x365E7A).withAlphaComponent(navAlpha)
        headerView.NavRestaurantTitle.alpha = navAlpha
        headerView.titlerestaurant.alpha = 1-navAlpha*5
    }
    @objc func buttonAction(sender: UIButton!) {
               self.navigationController?.popViewController(animated: true)
       }
}

import Foundation
import Foundation
import UIKit
extension UIImage{
    static func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)

        // create a 1 by 1 pixel context
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!

    }
}
