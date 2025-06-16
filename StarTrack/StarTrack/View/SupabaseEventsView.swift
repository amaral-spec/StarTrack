//
//  SupabaseEventsView.swift
//  StarTrack
//
//  Created by Gabriel Rugeri on 16/06/25.
//

import SwiftUI

struct SupabaseEventsView: View {
	@StateObject private var viewModel = EventViewModel()

	var body: some View {
		NavigationView {
			VStack {
				if viewModel.isLoading {
					ProgressView()
				} else {
					List {
						ForEach(viewModel.events) { event in
							VStack(alignment: .leading, spacing: 5) {
								Text(event.name ?? "Evento Sem Nome").font(.headline)
								Text(event.description ?? "").font(.caption).foregroundColor(.secondary)
								Text("Início: \(event.startAt, formatter: itemFormatter)")
									.font(.footnote)
									.foregroundColor(.blue)
							}
							.padding(.vertical, 5)
						}
						.onDelete(perform: viewModel.delete)
					}
				}
			}
			.navigationTitle("Eventos (Async/Await)")
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button(action: { viewModel.fetch() }) { Image(systemName: "arrow.clockwise") }
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: { viewModel.add() }) { Image(systemName: "plus") }
				}
			}
			.onAppear {
				viewModel.fetch()
			}
		}
	}
}

// Um formatador de data para usar na View.
private let itemFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	formatter.timeStyle = .medium
	return formatter
}()

