import UIKit

protocol ManyCustomTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

class ManyItemTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIButton!
    
    @IBOutlet weak var cellPrice: UILabel!

    
    @IBOutlet weak var itemLabel: UILabel!

    
    
    
    
    override func prepareForReuse() -> Void {
       cellPrice.text = nil
    }
    
    func initCellItem() {

        let deselectedImage = UIImage(named: "Deselect")
        radioButton.setImage(deselectedImage, for: .normal)
    //    radioButton.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
        itemLabel.textColor = UIColor(rgb: 0x365E7A)
        print("hello")
    }

    }

//    @objc func radioButtonTapped(_ radioButton: UIButton) {
//    print("radio button tapped")
//    let isSelected = !self.radioButton.isSelected
//    self.radioButton.isSelected = isSelected
//    let tableView = self.superview as! UITableView
//    let tappedCellIndexPath = tableView.indexPath(for: self)!
//    delegate?.didToggleRadioButton(tappedCellIndexPath)
//}
//
//func deselectOtherButton() {
//    let tableView = self.superview as! UITableView
//    let tappedCellIndexPath = tableView.indexPath(for: self)!
//    let indexPaths = tableView.indexPathsForVisibleRows
//    for indexPath in indexPaths! {
//        if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
//            let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! ManyItemTableViewCell
//            cell.radioButton.isSelected = false
//        }
//    }
//}

