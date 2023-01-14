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
        let calendar = Calendar.current
        let formatter = DateFormatter()
        let components = calendar.dateComponents([.weekday, .day, .month, .year], from: date)
        guard let weekday = components.weekday else {
            return nil
        }
        guard let day = components.day else {
            return nil
        }
        guard let month = components.month else {
            return nil
        }
        guard let year = components.year else {
            return nil
        }
        
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        guard let dateStart = formatter.date(from: "\(year)/\(month)/\(day) 00:00") else {
            return nil
        }
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
        }()
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeated = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeated])
        return realm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        
    }
    
    func saveWorkoutModel(model: WorkoutModel) {
        write {
            realm.add(model)
        }
    }
    
    func updateWorkoutModel(model: WorkoutModel, bool: Bool) {
        write {
            model.status = bool
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        write {
            realm.delete(model)
        }
    }
}
