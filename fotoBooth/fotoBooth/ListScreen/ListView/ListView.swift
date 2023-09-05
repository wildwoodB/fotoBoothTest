//
//  ListView.swift
//  fotoBooth
//
//  Created by Borisov Nikita on 01.09.2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject private var vm: AppDataManager
    @State private var selectedPhoto: PhotoElement? = nil
    @State var makeSegue: Bool = false
    @State var makeOtherSegue: Bool = false
    
    private var colums = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        VStack {
            FilterButton
            ListScrollView
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.sortFavs()
                } label: {
                    Image(systemName: "star")
                }
                
            }
        })
        .background(
            NavigationLink(
                destination: DetailLoadingView(photo: $selectedPhoto),
                isActive: $makeSegue,
                label: { EmptyView() }
            )
        )
    }
}

extension ListView {
    var ListScrollView: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: colums, spacing: 20, content: {
                    ForEach(vm.filteredPhotos) { photo in
                        ListCellView(photo: photo)
                            .onTapGesture {
                                segueToDetail(photo: photo)
                            }
                            .id(photo.id)
                        
                    }
                    
                })
                .padding()
            }
        }
    }
    
    var FilterButton: some View {
        if !vm.showingFavs {
            return AnyView(
                ZStack {
                    Color.blue
                    Text("Sort for Title")
                        .foregroundColor(.white)
                }
                    .frame(width: 120, height: 20)
                    .cornerRadius(10)
                    .onTapGesture {
                        vm.sorForTitile()
                    }
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    
    private func segueToDetail(photo: PhotoElement) {
        selectedPhoto = photo
        makeSegue.toggle()
    }
    
}



