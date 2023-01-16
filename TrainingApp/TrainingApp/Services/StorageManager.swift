//
//  StorageManager.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 13.01.2023.
//
import RealmSwift
import Foundation

typealias WorkoutArray = Results<WorkoutModel>
typealias UserArray = Results<UserModel>

class StorageManager {
    static let shared = StorageManager()
    private let realm: Realm
    
    private init() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        do {
            self.realm = try Realm()
        }
        catch {
            fatalError("no realm!")
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    func getWorkouts(date: Date) -> WorkoutArray? {
        let dateTimeZone = date.localDate()
        let weekday = dateTimeZone.getWeekdayNumber()
        let dateStart = dateTimeZone.startEndDate().0
        let dateEnd = dateTimeZone.startEndDate().1
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeated = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeated])
        return realm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        
    }
    
    func getWorkouts(predicate: NSPredicate, name: String) -> WorkoutArray {
        realm.objects(WorkoutModel.self).filter(predicate).sorted(byKeyPath: name)
    }
    
    func saveWorkoutModel(model: WorkoutModel) {
        write {
            realm.add(model)
        }
    }
    
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        write {
            model.status = bool
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int) {
        write {
            model.workoutSets = sets
            model.workoutTimer = timer
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        write {
            realm.delete(model)
        }
    }
    
    func getWorkoutsName() -> [String] {
        var nameArray = [String]()
        let workoutArray = realm.objects(WorkoutModel.self)

        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    func saveUserModel(model: UserModel) {
       write {
            realm.add(model)
        }
    }
    
    func updateUserModel(model: UserModel) {
        let users = realm.objects(UserModel.self)

        try! realm.write {
            users[0].userFirstName = model.userFirstName
            users[0].userSecondName = model.userSecondName
            users[0].userHeight = model.userHeight
            users[0].userWeight = model.userWeight
            users[0].userTarget = model.userTarget
            users[0].userImage = model.userImage
        }
    }
    
    func getUserArray() -> UserArray {
        realm.objects(UserModel.self)
    }
}
