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
    // unused but fixes preview crash
    let container = try? ModelContainer(for: Project.self)
    _ = container

    return NavigationStack {
        ContentListView(predicate: nil, sort: SortDescriptor(\.updatedDate))
            .background(Color.listBackground)
            .scrollContentBackground(.hidden)
    }
    .previewModelContainer()
}
