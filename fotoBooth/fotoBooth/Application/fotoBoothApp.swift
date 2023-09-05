//
//  fotoBoothApp.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 31.08.2023.
//

import SwiftUI

@main
struct fotoBoothApp: App {
    
    @StateObject private var vm = AppDataManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
                    .navigationBarHidden(false)
            }
            .environmentObject(vm)
        }
    }
}
