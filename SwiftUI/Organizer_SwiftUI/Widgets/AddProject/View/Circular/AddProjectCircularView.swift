//
//  AddProjectCircularView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 02/11/2023.
//

import SwiftUI

struct AddProjectCircularView: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .font(.system(size: 17, weight: .bold))
            .padding(10)
            .background(.floatingButton)
            .clipShape(.circle)
    }
}
