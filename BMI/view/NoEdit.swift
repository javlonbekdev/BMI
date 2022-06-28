//
//  NoEdit.swift
//  BMI
//
//  Created by Javlonbek iOS Dev on 26/06/22.
//

import SwiftUI


struct NoEdit: View {
    var items: Model
    var body: some View {
        VStack{
            Spacer()
            Text("\(items.group ?? "") - 18 guruh talabasining Bitiruv malakaviy ishi mavzusi")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text((items.name ?? "").prefix(items.name!.count-1))
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()
        }
        .navigationBarTitle(items.student ?? "", displayMode: .inline)
    }
}
