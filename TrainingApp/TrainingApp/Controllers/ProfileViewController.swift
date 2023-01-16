//
//  ProfileViewController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 13.01.2023.
//

import UIKit

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}

class ProfileViewController: UIViewController {
    
    private let storageManager = StorageManager.shared
    private var userArray: UserArray?
    
    private var resultWorkout = [ResultWorkout]()
    
    private let idProfileCollectionViewCell = "Cell"
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .center
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userPhotoView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR NAME"
        label.font = .robotoBold24()
        label.textColor = .white
        return label
    }()
    
    private let userHeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: _"
        label.font = .robotoBold16()
        label.textColor = .specialGray
        return label
    }()
    
    private let userWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight: _"
        label.font = .robotoBold16()
        label.textColor = .specialGray
        return label
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing ", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .specialGreen
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "profileEditing"), for: .normal)
        button.addTarget(self, action: #selector(editingButtonTap), for: .touchUpInside)
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.bounces = false
        collectionVIew.showsHorizontalScrollIndicator = false
        collectionVIew.backgroundColor = .none
        return collectionVIew
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.text = "TARGET: 0 workouts"
        label.font = .robotoBold16()
        label.textColor = .specialGray
        return label
    }()
    
    private let workoutsNowLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoBold24()
        label.textColor = .specialGray
        return label
    }()
    
    private let workoutsTargetLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .robotoBold24()
        label.textColor = .specialGray
        return label
    }()
    
    private let targetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .specialBrown
        return view
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .specialBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 14
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: false)
        progressView.layer.sublayers?[1].cornerRadius = 14
        progressView.subviews[1].clipsToBounds = true
        return progressView
    }()
    
    private var targetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private var userParamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArray = storageManager.getUserArray()
        
        setupViews()
        setDelegates()
        getWorkoutResults()
        setupUserParameters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUserParameters()
    }
    
    override func viewDidLayoutSubviews() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }
    
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubviews(profileLabel,
                         userPhotoView,
                         avatarImageView,
                         userNameLabel,
                         userParamStackView,
                         editingButton,
                         collectionView,
                         targetLabel,
                         targetStackView,
                         targetView,
                         progressView)
        
        userParamStackView.addArrangedSubviews(userHeightLabel, userWeightLabel)
        targetStackView.addArrangedSubviews(workoutsNowLabel, workoutsTargetLabel)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCollectionViewCell)
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userPhotoView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 45),
            userPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            userPhotoView.heightAnchor.constraint(equalToConstant: 110),
            
            userNameLabel.bottomAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: -20),
            userNameLabel.centerXAnchor.constraint(equalTo: userPhotoView.centerXAnchor),
            
            userParamStackView.topAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: 5),
            userParamStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            editingButton.topAnchor.constraint(equalTo: userPhotoView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editingButton.heightAnchor.constraint(equalToConstant: 25),
            editingButton.widthAnchor.constraint(equalToConstant: 75),
            
            collectionView.topAnchor.constraint(equalTo: userParamStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            targetLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            targetStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 10),
            targetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            targetStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            targetView.topAnchor.constraint(equalTo: targetStackView.bottomAnchor, constant: 3),
            targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetView.heightAnchor.constraint(equalToConstant: 28),
            
            progressView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func editingButtonTap() {
        let settingViewController = SettingViewController()
        settingViewController.modalPresentationStyle = .fullScreen
        present(settingViewController, animated: true)
    }
    
    private func setupUserParameters() {
        guard let userArray = userArray else {
            return
        }
        
        if !userArray.isEmpty {
            userNameLabel.text = userArray[0].userFirstName + userArray[0].userSecondName
            userHeightLabel.text = "Height: \(userArray[0].userHeight)"
            userWeightLabel.text = "Weight: \(userArray[0].userWeight)"
            targetLabel.text = "TARGET: \(userArray[0].userTarget) workouts"
            workoutsTargetLabel.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            avatarImageView.image = image
        }
    }

    private func getWorkoutResults() {
        let nameArray = storageManager.getWorkoutsName()
        
        for name in nameArray {
            let predicateName = NSPredicate(format: "workoutName = '\(name)'")
            let workoutArray = storageManager.getWorkouts(predicate: predicateName, name: "workoutName")
            var result = 0
            var image: Data?
            
            workoutArray.forEach { model in
                result += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCollectionViewCell, for: indexPath) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialGreen : .specialDarkYellow)
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.07,
               height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.setProgress(0.6, animated: true)
    }
}
