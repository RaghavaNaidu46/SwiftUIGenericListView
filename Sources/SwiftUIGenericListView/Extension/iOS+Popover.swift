//
//  CustomPopover.swift
//  ZLensFeedback
//
//  Created by Raghava Dokala on 05/09/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func iOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirection:UIPopoverArrowDirection, @ViewBuilder content: @escaping ()->Content)->some View{
        self.background {
            PopOverController(isPresented: isPresented, arrowDirection:arrowDirection, content: content ())
        }
    }
}

struct PopOverController<Content: View>: UIViewControllerRepresentable{
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    @State private var alreadyPresented: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context){
        if alreadyPresented{
            print("isPresented: \(isPresented)")
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content>{
                
                hostingController.rootView = content
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            if !isPresented {
                //Closing Popover
                DispatchQueue.main.async {
                    alreadyPresented = false
                    context.coordinator.changeRootViewOpacity(to: 1.0, for: uiViewController.view.superview?.superview?.superview)

                }
                uiViewController.children.first?.dismiss(animated: true) {
                    //Resetting alreadyPresented State
                }
            }
        }else{
            if isPresented{
                //Presenting Popover
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                //Connecting Delegate
                controller.presentationController?.delegate = context.coordinator
                /// - We Need to Attach the Source View So that it will show Arrow At Correct Position
                controller.popoverPresentationController?.sourceView = uiViewController.view
                context.coordinator.changeRootViewOpacity(to: 0.4, for: uiViewController.view.superview?.superview?.superview)

                //Simply Presenting PopOver Controller
                uiViewController.present (controller, animated: true)
            }
        }
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate{
        var parent: PopOverController
        init (parent: PopOverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style:
                                    UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
        // Method to change the opacity of the entire root view (ContentView)
        func changeRootViewOpacity(to opacity: CGFloat, for rootView: UIView?) {
            UIView.animate(withDuration: 0.3) {
                rootView?.alpha = opacity
            }
        }
    }
}

class CustomHostingView<Content: View>: UIHostingController<Content>{
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.intrinsicContentSize
    }
}
