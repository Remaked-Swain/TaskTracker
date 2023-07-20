import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskTracker")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var managedContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    // Task CRUD Operations
    func saveTask(_ task: TaskModel) {
        let taskEntity = TaskEntity(context: managedContext)
        taskEntity.id = task.id
        taskEntity.title = task.title
        taskEntity.taskDescription = task.taskDescription
        taskEntity.deadline = task.deadline
        taskEntity.isCompleted = task.isCompleted
        taskEntity.category = task.category
        
        saveContext()
    }
    
    func fetchTasks(completion: @escaping ([TaskEntity]) -> Void) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            completion(tasks)
        } catch {
            print("Error fetching tasks: \(error)")
            completion([])
        }
    }
    
    func updateTask(_ task: TaskModel) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            if let existingTask = tasks.first {
                existingTask.title = task.title
                existingTask.taskDescription = task.taskDescription
                existingTask.deadline = task.deadline
                existingTask.isCompleted = task.isCompleted
                existingTask.category = task.category
                saveContext()
            }
        } catch {
            print("Error updating task: \(error)")
        }
    }
    
    func deleteTask(_ task: TaskModel) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            if let taskToDelete = tasks.first {
                managedContext.delete(taskToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    
    // Category CRUD Operations
    func saveCategory(_ category: String) {
        let categoryEntity = CategoryEntity(context: managedContext)
        categoryEntity.name = category
        
        saveContext()
    }
    
    func fetchCategories(completion: @escaping ([CategoryEntity]) -> Void) {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        do {
            let categories = try managedContext.fetch(fetchRequest)
            completion(categories)
        } catch {
            print("Error fetching categories: \(error)")
            completion([])
        }
    }
    
    func deleteCategory(_ category: String) {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", category)
        
        do {
            let categories = try managedContext.fetch(fetchRequest)
            if let categoryToDelete = categories.first {
                managedContext.delete(categoryToDelete)
                saveContext()
            }
        } catch {
            print("Error deleting category: \(error)")
        }
    }
}
