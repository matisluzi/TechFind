import SafariServices
import SwiftUI
import UIKit

// porting SFSafariViewController from UIKit
struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    let configuration = SFSafariViewController.Configuration()
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        self.configuration.barCollapsingEnabled = false // prevents bug when SFSafariViewController is shown as a sheet
        return SFSafariViewController(url: self.url, configuration: self.configuration)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // nothing
    }
    
    typealias UIViewControllerType = SFSafariViewController
}
