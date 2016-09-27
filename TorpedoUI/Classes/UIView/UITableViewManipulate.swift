import Foundation
import UIKit

public extension UITableView {

    public func deselectAll(_ animated: Bool) {
        let selected = indexPathsForSelectedRows
        if let selectedPaths = selected {
            for indexPath in selectedPaths {
                deselectRow(at: indexPath, animated: animated)
            }
        }
    }

    public func insertRow(_ indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        insertRows(at: [indexPath], with: rowAnimation)
    }

    public func safeInsertRow(_ indexPath: IndexPath?, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        if let indexPath = indexPath {
            insertRow(indexPath, withRowAnimation: rowAnimation)
        }
    }

    public func deleteRow(_ indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        deleteRows(at: [indexPath], with: rowAnimation)
    }

    public func safeDeleteRow(_ indexPath: IndexPath?, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        if let indexPath = indexPath {
            deleteRow(indexPath, withRowAnimation: rowAnimation)
        }
    }

    public func reloadRow(_ indexPath: IndexPath, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        reloadRows(at: [indexPath], with: rowAnimation)
    }

    public func safeReloadRow(_ indexPath: IndexPath?, withRowAnimation rowAnimation: UITableViewRowAnimation) {
        if let indexPath = indexPath {
            reloadRow(indexPath, withRowAnimation: rowAnimation)
        }
    }

}
