import UIKit
import Parchment


class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    
    @IBOutlet weak var itemLabel: UILabel!
    var Selected = false

func initCellItem() {

//    let deselectedImage = UIImage(named: "Deselect")
//    radioButton.setImage(deselectedImage, for: .normal)

//    radioButton.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
    itemLabel.textColor = UIColor(rgb: 0x365E7A)
}

}

//    @objc func radioButtonTapped(_ radioButton: UIButton) {
//    print("radio button tapped")
//    let isSelected = !self.radioButton.isSelected
//    self.radioButton.isSelected = isSelected
//    if isSelected {
//        deselectOtherButton()
//    }
//    let tableView = self.superview as! UITableView
//    let tappedCellIndexPath = tableView.indexPath(for: self)!
//    delegate?.didToggleRadioButton(tappedCellIndexPath)
//}

//func deselectOtherButton() {
//    let tableView = self.superview as! UITableView
//    let tappedCellIndexPath = tableView.indexPath(for: self)!
//    let indexPaths = tableView.indexPathsForVisibleRows
//    for indexPath in indexPaths! {
//        if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
//            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! ItemTableViewCell
//            cell.radioButton.isSelected = false
//        }
//    }
//}
//}
