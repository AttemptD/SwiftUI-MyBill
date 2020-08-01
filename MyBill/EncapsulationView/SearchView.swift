//
//  SearchView.swift
//  JFQ
//
//  Created by Attempt D on 2020/3/24.
//  Copyright © 2020 Frank D. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    @Binding var clean : Bool

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            text = searchText
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "请输入搜索内容"
        searchBar.barStyle = .black
        searchBar.barTintColor = UIColor.init(named: "AllViewCircle")
        searchBar.tintColor = .white
        //searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        
        DispatchQueue.main.async {
            if self.clean == false{
                self.text.removeAll()
            }
        }
        
        uiView.text = text
    }
}

