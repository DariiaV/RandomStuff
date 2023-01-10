//
//  ViewController.swift
//  Animal Callery
//
//  Created by Дария Григорьева on 10.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private var gallery = [#imageLiteral(resourceName: "3-32479_animals-hd-wallpaper-funny-cute-animals-wallpapers-cute.jpg"), #imageLiteral(resourceName: "30881.jpg"), #imageLiteral(resourceName: "343178.jpg"), #imageLiteral(resourceName: "392887.jpg"), #imageLiteral(resourceName: "610828-bigthumbnail.jpg"), #imageLiteral(resourceName: "907729-free-cute-animal-backgrounds-1920x1200-tablet.jpg"), #imageLiteral(resourceName: "corgi_header_image.jpg"), #imageLiteral(resourceName: "free-wallpaper-16.jpg"), #imageLiteral(resourceName: "OlwQ9A.jpg"), #imageLiteral(resourceName: "wild-animal-wallpapers-desktop-images-free-wallpapers-cute-animals-wallpaper-of-animals-large-animal-photos-animality-1440x900.jpg")]
    
    private let imageViewBack: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Animal Gallery"
        label.font = UIFont(name: "Futura", size: 24)
        return label
    }()
    
    private let trashImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "trash.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .red
        return image
    }()
    
    private let originalSize: CGFloat = 300
    
    private var nextIndex = 0
    private var currentPicture: UIImageView?
    private var isActive = false
    
    private var activeSize: CGFloat {
        return originalSize + 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        showNextPicture()
    }
    
    private func setupView() {
        view.addSubview(imageViewBack)
        view.addSubview(label)
        view.addSubview(trashImageView)
        
        imageViewBack.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        trashImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewBack.topAnchor.constraint(equalTo: view.topAnchor),
            imageViewBack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewBack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewBack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            trashImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trashImageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            trashImageView.heightAnchor.constraint(equalToConstant: 50),
            trashImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func showNextPicture() {
        if let newPicture = createPicture() {
            currentPicture = newPicture
            showPicture(newPicture)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            newPicture.addGestureRecognizer(tap)
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
            swipe.direction = .left
            newPicture.addGestureRecognizer(swipe)
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            newPicture.addGestureRecognizer(pan)
            pan.delegate = self
        } else if gallery.isEmpty {
            let alert = UIAlertController(title: "You delete all picture 🤷‍♀️",
                                          message: nil,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        } else {
            nextIndex = 0
            showNextPicture()
        }
    }

    private func processPictureMovement(sender: UIPanGestureRecognizer, view: UIImageView) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(.zero, in: view)
        
        if view.frame.intersects(trashImageView.frame) {
            view.layer.borderColor = UIColor.red.cgColor
        } else {
            view.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    private func activateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.activeSize, height: self.activeSize)
            self.currentPicture?.layer.shadowOpacity = 0.5
            self.currentPicture?.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    private func deactivateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.originalSize, height: self.originalSize)
            self.currentPicture?.layer.shadowOpacity = 0
            self.currentPicture?.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
    private func createPicture() -> UIImageView? {
        guard nextIndex < gallery.count else {
            return nil
        }
        let imageView = UIImageView(image: gallery[nextIndex])
        imageView.frame = CGRect(x: self.view.frame.width,
                                 y: self.view.center.y - (originalSize / 2),
                                 width: originalSize,
                                 height: originalSize)
        imageView.isUserInteractionEnabled = true
        
        // Тень
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 10
        
        //Frame
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        nextIndex += 1
        return imageView
    }
    
    private func showPicture(_ imageView: UIImageView) {
        self.view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.4) {
            imageView.center = self.view.center
        }
    }
    
    private func hidePicture(_ imageView: UIImageView) {
       
        UIView.animate(withDuration: 0.4, animations: {
            self.currentPicture?.frame.origin.y = -self.originalSize
        }) { (_) in
            imageView.removeFromSuperview()
        }
    }
    
    private func deletePicture(imageView: UIImageView) {
        self.gallery.remove(at: nextIndex - 1)
        isActive = false
        
        UIView.animate(withDuration: 0.4, animations: {
            imageView.alpha = 0
        }) { (_) in
            imageView.removeFromSuperview()
        }
        showNextPicture()
    }
    
    @objc private func handleTap() {
        isActive = !isActive
        
        if isActive {
            activateCurrentPicture()
        } else {
            deactivateCurrentPicture()
        }
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        guard !isActive else {
            return
        }
        guard let currentPicture = currentPicture else {
            return
        }
        
        hidePicture(currentPicture)
        showNextPicture()
    }
    
    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let view = currentPicture, isActive else {
            return
        }
        switch sender.state {
        
        case .began, .changed:
            processPictureMovement(sender: sender, view: view)
        case .ended:
            if view.frame.intersects(trashImageView.frame) {
                deletePicture(imageView: view)
            }
        default:
            break
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


