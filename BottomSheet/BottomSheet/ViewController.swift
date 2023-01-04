//
//  ViewController.swift
//  BottomSheet
//
//  Created by Prahlad Dhungana on 2022-06-13.
//

import UIKit

protocol ModalContainer: UIViewController {
    var delegate: ModalViewDelegate? { get set }
    var headerTitle: String { get }
    var subTittle: String? { get }
    var isFullView: Bool { get }
    func show(in controller: UIViewController )
}

extension ModalContainer {
    var subTittle: String? {  nil  }
    var isFullView: Bool { false }
    
    func show(in controller: UIViewController) {
        // main dimissable controller
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let modalController = storyboard.instantiateViewController(withIdentifier: "ViewC") as? ViewController else { return }
        
        modalController.modalPresentationStyle = .overCurrentContext
     
        // configure modal content

        modalController.setupContainerView(modalContainerView: self)
   
        // controller that presents
        controller.present(modalController, animated: true)
    }
}

protocol ModalViewDelegate: AnyObject {
    func openModel(height: CGFloat)
}

class ViewController: UIViewController,  ModalViewDelegate  {
    // MARK: - Properties
    private var maxTopConstraintConstant: CGFloat = 0.0
    var modalContainerView: ModalContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupPanGesture()
       // setupContainerView()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       setupContainerView()
    }
    
    func setupContainerView(modalContainerView: ModalContainer?) {
        modalContainerView?.delegate = self
        self.modalContainerView = modalContainerView
    }
    
    func openModel(height: CGFloat) {
        guard let isFullView = modalContainerView?.isFullView else { return }
        let tableViewBottomInset: CGFloat = 30.0
        
        // for iphones with no home button
        let headerHeight = containerHeader.frame.height
        let calculatedHeight = min((height + tableViewBottomInset + headerHeight), view.frame.height)
        
        let topConstraintConstant = isFullView ? -view.frame.height : -calculatedHeight
        
        animate(height: topConstraintConstant)
    }
    
    private func setupContainerView() {
        guard let modalContainer = modalContainerView else { return }
    
        // controller that calls the function
        modalContainer.modalPresentationStyle = .overCurrentContext
        modalContainer.view.bounds = view.bounds
        modalContainer.view.autoresizingMask = [.flexibleWidth,  .flexibleHeight]
        addChild(modalContainer)
        contentView.addSubview(modalContainer.view)
        didMove(toParent: self)
    }

    private func setupView() {
        // hide images and cross buttons
        let isFullView = (modalContainerView?.isFullView ?? false)
        // notchIcon.isHidden = isFullView
        // crossButton.isHidden = !isFullView
        
        if !isFullView {
            containerViewWrapper.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            containerViewWrapper.layer.masksToBounds = true
            containerViewWrapper.layer.cornerRadius = 30
        }
    }
    
    deinit {
        print("Dealloc")
    }

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var containerHeader: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewWrapper: UIView!
    @IBOutlet weak var overlay: UIView!
    
    // MARK: - tap
    
    private func setupPanGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        containerHeader.addGestureRecognizer(pan)
    }

    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: containerHeader)
        switch recognizer.state {
        case .began:
            self.overlay.alpha = 0
        case .changed:
            handleChanged( translation: translation)
        case .ended:
            handleEnded(recognizer, translation: translation)
        default:
             return
        }
    }
    
    private func handleChanged(translation: CGPoint) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.overlay.alpha = 0
            self.containerViewWrapper.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }
    }
    
    private func handleEnded(_ recognizer: UIPanGestureRecognizer, translation: CGPoint) {
        let velocity = recognizer.velocity(in: containerHeader)
        
        if translation.y > 200 || velocity.y > 400 {
            self.overlay.isHidden = true
            dismiss(animated: true)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.overlay.alpha = 0.6
            self.containerViewWrapper.transform = .identity
        }
    }
    
    private func animate(height: CGFloat) {
        UIView.animate(withDuration: 0.5, delay:0, options: .curveEaseInOut) {
            self.topConstraint.constant = height
            self.overlay.alpha = 0.6
            self.view.layoutIfNeeded()
        }
    }
}

