//
//  BreedListView.swift
//  KaMPKitiOS
//
//  Created by Brady Aiello on 7/10/21.
//  Copyright © 2021 Touchlab. All rights reserved.
//

import Combine
import KMPNativeCoroutinesCombine
import SwiftUI
import SwiftUIRefresh
import shared


struct BreedListView: View {
    @ObservedObject
    var observableDataState: ObservableDataState
    
    var nativeViewModel: NativeViewModel

    
    init(_ nativeViewModel: NativeViewModel) {
        self.nativeViewModel = nativeViewModel
        observableDataState = ObservableDataState(nativeViewModel)
    }
    
    var body: some View {
        switch observableDataState.dataStateNative {
            case DataStateNative.Empty:
                return EmptyView()
            case DataStateNative.Loading(let previousState):
                return LoadingView(previousState)
            case DataStateNative.Error(let error):
                return ErrorView(error)
            case DataStateNative.Success(let data):
                return SuccessView(data)
        }
    }
    
    func LoadingView(_ previousState: DataStateNative<ItemDataSummary>?) -> AnyView {
        if let previousDataState = previousState {
            switch previousDataState {
                case DataStateNative.Empty:
                    return EmptyView()
                case DataStateNative.Loading:
                    return AnyView(Text("Loading doggos... 🐕"))
                case DataStateNative.Error(let error):
                    return ErrorView(error)
                case DataStateNative.Success(let data):
                    return SuccessView(data)
            }
            
        } else {
            return AnyView(Text("Loading doggos... 🐕"))
        }

    }
                    
    func EmptyView() -> AnyView {
        return AnyView(
            ScrollView {
                Text("No doggos! 🥺")
                    .scaledToFill()
                List {
                    
                }.scaledToFill()
            }
        )
    }
    
    func ErrorView(_ error: String) -> AnyView {
        
        return AnyView(
            VStack {
                Text("Error: \(error)")
                    .scaledToFill()
                List {
                    
                }
                .scaledToFill()
                .pullToRefresh(isShowing: $observableDataState.isLoading) {
                    nativeViewModel.refreshBreeds(forced: true)
                }
            }
        )
    }
    
    func SuccessView(_ data: ItemDataSummary)  -> AnyView {
        return AnyView(
            List {
                ForEach(data.allItems, id: \.self) { item in
                    BreedRowView(item, nativeViewModel.updateBreedFavorite)
                }
            }
            .pullToRefresh(isShowing: $observableDataState.isLoading) {
                nativeViewModel.refreshBreeds(forced: true)
            }
        )
    }
    
}

