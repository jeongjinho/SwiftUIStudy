//
//  FavoritePrimesView.swift
//  SwiftUIBoot
//
//  Created by jeong jinho on 2022/12/15.
//

import SwiftUI
import ComposableArchitecture
import FavoritePrimes
import Counter
import PrimeModal


//struct FavoritePrimesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritePrimesView(
//            store: Store(initialValue: AppState(), reducer:  combine(
//                pullback(counterReducer(state:action:), value: \.count, action: \.counter) ,
//                pullback(primeModalReducer(state:action:), value: \.primeModal,  action: \.primeModal) ,
//                pullback(favoritePrimesReducer(state:action:), value: \.favoritePrimes, action: \.favoritePrimes))
//            )
//        
//            )
//    }
//}
