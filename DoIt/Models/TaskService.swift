//
//  PostService.swift
//  DoIt
//
//  Created by Yulia on 05.12.2021.
//
//

import Firebase

struct TaskService {
    
    static let shared = TaskService()
    
    func uploadTask(task: Task, completion: @escaping(Error?, DatabaseReference)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var values = [
                      "title": task.title,
                      "description": task.description ?? "",
                      "deadline": Int(task.deadline?.timeIntervalSince1970 ?? 0),
                      "is_done": task.isDone,
                      "uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "color": [task.color.cgColor.components?[0],
                                task.color.cgColor.components?[1],
                                task.color.cgColor.components?[2]
                                ]
        ] as [String : Any]
        
        REF_TASKS.childByAutoId().updateChildValues(values) { (error, ref) in
            guard let taskID = ref.key else { return }
            REF_USER_TASKS.child(uid).updateChildValues([taskID : 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTask(taskId: String, completion: @escaping(Task) -> Void){
        REF_TASKS.child(taskId).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            guard let image = dictionary["image"] as? String else { return }
            guard let title = dictionary["title"] as? String else { return }
            guard let description = dictionary["description"] as? String else { return }
            guard let deadline = dictionary["deadline"] as? Int else { return }
            guard let isDone = dictionary["is_done"] as? Bool else { return }
            guard let creatorId = dictionary["uid"] as? String else { return }
            guard let color = dictionary["color"] as? [Int] else { return }


            UserService.shared.fetchUser(uid: uid) { (user) in

                let task = Task(
                    image: nil,
                    title: title,
                    description: description,
                    deadline: Date(timeIntervalSince1970: TimeInterval(deadline)),
                    isDone: isDone,
                    creatorId: 0,
                    color: UIColor(red: CGFloat(color[0]) * 255.0, green: CGFloat(color[1]) * 255.0, blue: CGFloat(color[2]) * 255.0, alpha: 1.0)
                )
                completion(task)
            }
        }
    }
    
    func fetchTasks(forUser user: User, completion: @escaping([Task]) -> Void) {
        var tasks = [Task]()
        REF_USER_TASKS.child(user.uid).observe(.childAdded) { snapshot in
            let taskId = snapshot.key
            
            self.fetchTask(taskId: taskId) { task in
                tasks.append(task)
                completion(tasks)
            }
        }
    }
}
