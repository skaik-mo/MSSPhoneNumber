//_________SKAIK_MO_________
//
//  Extensions.swift
//  MSSPhoneNumber
//
//  Created by Mohammed Skaik on 17/09/2023.
//

import Foundation
import UIKit

extension Foundation.Bundle {
    static var framework: Bundle = {
        #if SWIFT_PACKAGE
            // If installed via SPM

            let bundleName = "MSSPhoneNumber_MSSPhoneNumber"

            let candidates = [
                // Bundle should be present here when the package is linked into an App.
                Bundle.main.resourceURL,

                // Bundle should be present here when the package is linked into a framework.
                Bundle(for: MSSPhoneNumber.self).resourceURL,

                // For command-line tools.
                Bundle.main.bundleURL,
            ]

            for candidate in candidates {
                let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
                if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                    return bundle
                }
            }
        #endif
        // If installed via CocoaPods or other means
        return Bundle(for: MSSPhoneNumber.self)

    }()
}

extension String {
    var _isValidValue: Bool {
        return !self._removeWhiteSpace.isEmpty
    }

    var _removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var _localizedKey: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIResponder {
    static var id: String {
        String(describing: self)
    }
}

extension UIViewController {
    func showError(title: String = Strings.WRONG_TITLE, message: String?, okButtonAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: Strings.OK_TITLE, style: .destructive) { _ in
            okButtonAction?()
        }
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
}

extension UIApplication {
    var rootViewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
}
