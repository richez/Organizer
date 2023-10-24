//
//  MainView.swift
//  Organizer_SwiftUI
//
//  Created by Thibaut Richez on 11/10/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView()
            .navigationSplitViewStyle(.balanced)
            .background(.listBackground)
            .onOpenURL { url in
                guard let deeplink = Deeplink(url: url) else { return }
                print(deeplink)
                print(deeplink.url!)
            }
    }
}

#Preview {
    ModelContainerPreview {
        MainView()
    }
}
