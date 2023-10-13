//
//  ContentListView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 13/10/2023.
//

import SwiftData
import SwiftUI

struct ContentListView: View {
    @Query private var contents: [ProjectContent]

    init(predicate: Predicate<ProjectContent>?, sort: SortDescriptor<ProjectContent>) {
        self._contents = Query(filter: predicate, sort: [sort])
    }

    var body: some View {
        List {
            ForEach(self.contents) { content in
                Text(content.title)
                    .listRowBackground(Color.listBackground)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ModelContainerPreview {
        NavigationStack {
            ContentListView(predicate: nil, sort: SortDescriptor(\.updatedDate))
                .listStyle()
        }
    }
}
