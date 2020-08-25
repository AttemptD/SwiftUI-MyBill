import SwiftUI

extension View {

    func hackNavigationToAllowSpipeBackWhenHidden() -> some View {
        return background(NavigationConfigurator())
    }

}

private struct NavigationConfigurator: UIViewControllerRepresentable {

    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        weak var navigationController: UINavigationController?
        weak var originalDelegate: UIGestureRecognizerDelegate?

        deinit {
            navigationController?.interactivePopGestureRecognizer?.delegate = originalDelegate
        }

        override func responds(to aSelector: Selector!) -> Bool {
            if aSelector == #selector(gestureRecognizer(_:shouldReceive:)) {
                return true
            } else if let responds = originalDelegate?.responds(to: aSelector) {
                return responds
            } else {
                return false
            }
        }

        override func forwardingTarget(for aSelector: Selector!) -> Any? {
            return originalDelegate
        }

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if let navigationController = navigationController,
                navigationController.isNavigationBarHidden {

                return true
            } else if let result = originalDelegate?.gestureRecognizerShouldBegin?(gestureRecognizer) {
                return result
            } else {
                return false
            }
        }

        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if let navigationController = navigationController,
                navigationController.isNavigationBarHidden {

                return true
            } else if let result = originalDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) {
                return result
            } else {
                return false
            }
        }
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        return UIViewController()
    }

    func makeCoordinator() -> NavigationConfigurator.Coordinator {
        return Coordinator()
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<NavigationConfigurator>) {

        uiViewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        guard !(uiViewController.navigationController?.interactivePopGestureRecognizer?.delegate is Coordinator) else { return }
         //uiViewController.navigationController?.navigationBar.backgroundColor = UIColor.orange
        context.coordinator.navigationController = uiViewController.navigationController
        context.coordinator.originalDelegate = uiViewController.navigationController?.interactivePopGestureRecognizer?.delegate
        uiViewController.navigationController?.interactivePopGestureRecognizer?.delegate = context.coordinator
       
    }

}
