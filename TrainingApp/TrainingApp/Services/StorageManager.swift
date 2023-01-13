//
//  StorageManager.swift
//  TrainingApp
//
//  Created by Дария Григорьева on 13.01.2023.
//
import RealmSwift
import Foundation

typealias WorkoutArray = Results<WorkoutModel>

class StorageManager {
    static let shared = StorageManager()
    private let localRealm = try! Realm()
    
    private init() {}
    
    private func write(completion: () -> Void) {
        do {
            try localRealm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    func getWorkouts(date: Date) -> WorkoutArray? {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else {
            return nil
        }
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
        }()
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeated = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeated])
        return localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        
    }
    
    func saveWorkoutModel(model: WorkoutModel) {
        write {
            localRealm.add(model)
        }
    }
}

//class StorageManager {
//    static let shared = StorageManager()
//    let realm = try! Realm()
//
//    private init() {}
//
//    // MARK: - Task List
//    func save(_ taskLists: [TaskList]) {
//        write {
//            realm.add(taskLists)
//        }
//    }
//
//    func save(_ taskList: TaskList) {
//        write {
//            realm.add(taskList)
//        }
//    }
//
//    func delete<T>(_ taskList: T) {
//        write {
//            if let objectToDelete = taskList as? TaskList {
//                realm.delete(objectToDelete.tasks)
//                realm.delete(objectToDelete)
//            } else if let objectToDelete = taskList as? Task {
//                realm.delete(objectToDelete)
//            }
//        }
//    }
//
//    func edit<T>(_ taskList: T, newValue: String, newNote: String? = nil) {
//        write {
//            if let objectToEdit = taskList as? TaskList {
//                objectToEdit.name = newValue
//            } else if let objectToEdit = taskList as? Task {
//                objectToEdit.name = newValue
//                objectToEdit.note = newNote ?? ""
//            }
//        }
//    }
//
//    func done<T>(_ taskList: T) {
//        write {
//            if let objectToDone = taskList as? TaskList {
//                objectToDone.tasks.setValue(true, forKey: "isComplete")
//            } else if let objectToDone = taskList as? Task {
//                objectToDone.isComplete.toggle()
//            }
//        }
//    }
//
//    // MARK: - Tasks
//    func save(_ task: Task, to taskList: TaskList) {
//        write {
//            taskList.tasks.append(task)
//        }
//    }
//
//    private func write(completion: () -> Void) {
//        do {
//            try realm.write {
//                completion()
//            }
//        } catch {
//            print(error)
//        }
//    }
//}
