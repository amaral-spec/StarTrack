//
//  ContentView.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import Supabase
import SwiftUI

struct ContentView: View {
  @State var todos: [Todo] = []

  var body: some View {
	NavigationStack {
	  List(todos) { todo in
		Text(todo.title)
	  }
	  .navigationTitle("Todos")
	  .task {
		do {
		  todos = try await supabase.from("todos").select().execute().value
		} catch {
		  debugPrint(error)
		}
	  }
	}
  }
}

#Preview {
  ContentView()
}

