import UIKit

extension CATransaction {
    
    static func performWithoutAnimation(block: () -> Void) {
        CATransaction.setAnimationDuration(0)
        CATransaction.begin()
        block()
        CATransaction.commit()
    }
}
