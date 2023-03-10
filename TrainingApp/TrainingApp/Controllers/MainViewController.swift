//
//  MainViewController.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 11.01.2023.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "PhotoBack")
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.tintColor = .specialDarkGreen
        button.setTitle("Add workout", for: .normal)
        button.titleLabel?.font = .robotoMedium12()
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.addShadowOnView()
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let workoutTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout Today"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        return tableView
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private let weatherView = WeatherView()
    private let calendarView = CalendarView()
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    private let storageManager = StorageManager.shared
    private var workoutArray: WorkoutArray?
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        workoutArray = storageManager.getWorkouts(date: Date())
        calendarView.delegate = self
        checkWorkoutsToday()
        setupLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUserParameters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showOnboarding()
    }
    
    private func setupTableView() {
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupViews() {
        
        view.backgroundColor = .specialBackground
        view.addSubviews(calendarView,
                         userNameLabel,
                         avatarImageView,
                         addWorkoutButton,
                         workoutTodayLabel,
                         tableView,
                         weatherView,
                         noWorkoutImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            weatherView.topAnchor.constraint(equalTo: addWorkoutButton.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor),
            weatherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    private func setupUserParameters() {
        let userArray = storageManager.getUserArray()
        if !userArray.isEmpty {
            userNameLabel.text = userArray[0].userFirstName + " " + userArray[0].userSecondName
            
            guard let data = userArray[0].userImage else { return }
            guard let image = UIImage(data: data) else { return }
            avatarImageView.image = image
        }
    }
    
    private func checkWorkoutsToday() {
        if let workoutArray,
           workoutArray.isEmpty {
            tableView.isHidden = true
            noWorkoutImageView.isHidden = false
        } else {
            tableView.isHidden = false
            noWorkoutImageView.isHidden = true
            tableView.reloadData()
        }
    }
    
    private func showOnboarding() {
        let userDefaults = UserDefaults.standard
        let onBoardingWasViewed = userDefaults.bool(forKey: "OnBoardingWasViewed")
        if onBoardingWasViewed == false {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: false)
        }
    }
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutVC = NewWorkoutViewController()
        newWorkoutVC.delegate = self
        present(newWorkoutVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as? WorkoutTableViewCell,
              let workoutArray else {
            return UITableViewCell()
        }
        
        cell.cellConfigure(model: workoutArray[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let workoutArray else {
            return nil
        }
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel = workoutArray[indexPath.row]
            self.storageManager.deleteWorkoutModel(model: deleteModel)
            self.checkWorkoutsToday()
        }
        
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension MainViewController: NewWorkoutViewControllerDelegate {
    // MARK: - NewWorkoutViewControllerDelegate
    func didSaveModel() {
        checkWorkoutsToday()
    }
}

extension MainViewController: StartWorkoutViewControllerDelegate {
    // MARK: - StartWorkoutViewControllerDelegate
    func didTapFinishWorkout() {
        checkWorkoutsToday()
    }
}

extension MainViewController: WorkoutTableViewCellDelegate {
    // MARK: - StartWorkoutProtocol
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            let startWorkoutViewController = RepsWorkoutViewController()
            startWorkoutViewController.modalPresentationStyle = .fullScreen
            startWorkoutViewController.workoutModel = model
            startWorkoutViewController.delegate = self
            present(startWorkoutViewController, animated: true)
        } else {
            let timerWorkoutViewController = TimerWorkoutViewController()
            timerWorkoutViewController.modalPresentationStyle = .fullScreen
            timerWorkoutViewController.workoutModel = model
            present(timerWorkoutViewController, animated: true)
        }
    }
}

extension MainViewController: CalendarViewDelegate {
    // MARK: - CalendarViewDelegate
    func selectItem(date: Date) {
        workoutArray = storageManager.getWorkouts(date: date)
        checkWorkoutsToday()
    }
}

extension MainViewController: CLLocationManagerDelegate {
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            getWeather(lat: Double(lat), lon: Double(lon))
            
        }
    }
    
    private func getWeather(lat: Double, lon: Double) {
        NetworkDataFetch.shared.fetchWeather(lat: lat, lon: lon) { [weak self] model, error in
            guard let self = self else { return }
            if error == nil {
                guard let model = model else {
                    return
                }
                self.weatherView.weatherStatusLabel.text = "\(model.currently.iconLocal) \(model.currently.temperatureCelsius)°C"
                self.weatherView.weatherDescriptionLabel.text = model.currently.description
                
                guard let imageIcon = model.currently.icon else {
                    return
                }
                self.weatherView.weatherImageView.image = UIImage(named: imageIcon)
            } else {
                self.alertOk(title: "Error", message: "No weather data")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
