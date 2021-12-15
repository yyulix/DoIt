//
//  FirebaseConstants.swift
//  DoIt
//
//  Created by Yulia on 04.12.2021.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()

let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
let STORAGE_TASK_IMAGES = STORAGE_REF.child("task_images")

let DB_REF = Database.database().reference()

let REF_USERS = DB_REF.child("users")
let REF_TASKS = DB_REF.child("tasks")
let REF_USER_TASKS = DB_REF.child("user-tasks")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWING = DB_REF.child("user-following")

