//import SwiftUI
//import MapKit
//

import SwiftUI
import MapKit

struct ObservatoryDetailView: View {
    let observatory: Observatory
    @Environment(\.dismiss) var dismiss
	
	@State private var isLocationExpanded = false
	@State private var isTechnologiesExpanded = false
	@State private var isHighlightExpanded = false
	@State private var isVisitationExpanded = false

    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 20) {
				Text(observatory.fact.name)
                    .font(.title)
                    .bold()

                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: observatory.gpsLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                    )),
                    annotationItems: [observatory]) { _ in
                    MapMarker(coordinate: observatory.gpsLocation, tint: .red)
                }
                .frame(height: 200)
                .cornerRadius(10)

                HStack{
                    Image(systemName: "location.fill")
                    Text("Localização:")
                        .font(.headline)
				}
				VStack{
                    Text("\(observatory.city), \(observatory.state)")
                        .font(.subheadline)
						.padding(-10)
						.padding(.horizontal, 25)
                }
                .padding()
                .padding(.vertical, -15)

                HStack{
                    Image(systemName: "gearshape.fill")
                    Text("Tecnologias disponíveis")
						.font(.headline)
				}
				VStack{
					Text("\(observatory.technologiesAvailable.joined(separator: ", "))")
						.font(.subheadline)
						.padding(-10)
						.padding(.horizontal, 25)
                }
                .padding()
                .padding(.vertical, -15)

                HStack{
                    Image(systemName: "star.fill")
                    Text("Destaque científico")
						.font(.headline)
				}
				VStack{
					Text("\(observatory.cientificHighlight.joined(separator: ", "))")
						.font(.subheadline)
						.padding(-10)
						.padding(.horizontal, 25)
                }
                .padding()
                .padding(.vertical, -15)

                HStack{
                    Image(systemName: "person.2.fill")
                    Text("Visitação")
                        .font(.headline)
				}
				VStack{
					Text("\(observatory.visitation.openToPublic)")
						.font(.subheadline)
						.padding(-10)
						.padding(.horizontal, 25)
                }
                .padding()
                .padding(.vertical, -15)

            }
            .padding()
            .padding(.top, -50)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Voltar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ObservatoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ObservatoriesView()
    }
}

struct ObservatoriesView: View {
    @StateObject private var locationManager = LocationManager()
    
    @Environment(\.managedObjectContext) var context

    @State private var searchText = ""
    @State private var selectedObservatory: Observatory?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -22.911304857516285, longitude: -47.06560557293485),
        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    )

    var body: some View {
        NavigationView {
            VStack {
                let manager = CoreDataManager(context: context)
                let allObservatories = manager.fetchObservatories()
                // Barra de pesquisa
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                // Mapa com pins
                Map(coordinateRegion: $region, annotationItems: allObservatories) { observatory in
                    MapAnnotation(coordinate: observatory.gpsLocation) {
                        VStack(spacing: 0) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .onTapGesture {
                                    selectedObservatory = observatory
                                    withAnimation {
                                        region.center = observatory.gpsLocation
                                        region.span = MKCoordinateSpan(
                                            latitudeDelta: 0.04,
                                            longitudeDelta: 0.04
                                        )
                                    }
                                }

                            Text(observatory.fact.name)
                                .font(.caption2)
                                .fixedSize()
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(radius: 3)
                        }
                    }
                }
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
                .onAppear {
                    // Centraliza o mapa na localização do usuário
                    if let userLocation = locationManager.location {
                        region.center = userLocation.coordinate
                        region.span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    } else if let first = allObservatories.first {
                        // Se a localização do usuário não estiver disponível, centraliza no primeiro observatório
                        region.center = first.gpsLocation
                        region.span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    }
                }

//                 Lista de observatórios
                List(allObservatories) { observatory in
                    VStack(alignment: .leading) {
                        Text(observatory.fact.name)
                            .font(.headline)
                        Text("\(observatory.city), \(observatory.state)")
                            .font(.subheadline)                // lista que vai puxar os dados do banco
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectedObservatory = observatory
                        withAnimation {
                            region.center = observatory.gpsLocation
                            region.span = MKCoordinateSpan(
                                latitudeDelta: 0.04,
                                longitudeDelta: 0.04
                            )
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Observatórios")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: PerfilView(), label: {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .frame(width: 50)
                            .padding(.top, 90)
                    })
                }
            }
            .sheet(item: $selectedObservatory) { observatory in
                ObservatoryDetailView(observatory: observatory)
            }
        }
        .onAppear {
//            let manager = CoreDataManager(context: context)
//            let allObservatories = manager.fetchObservatories()
        }
    }
}
