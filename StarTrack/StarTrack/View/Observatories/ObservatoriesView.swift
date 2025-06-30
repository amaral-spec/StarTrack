//import SwiftUI
//import MapKit
//

struct ObservatoryDetailView: View {
    let observatory: Observatory
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 20) {
                Text(observatory.name)
                    .font(.title)
                    .bold()

                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: observatory.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                    )),
                    annotationItems: [observatory]) { _ in
                    MapMarker(coordinate: observatory.coordinate, tint: .red)
                }
                .frame(height: 200)
                .cornerRadius(10)

                HStack{
                    Image(systemName: "location.fill")
                    Text("Localização:")
                        .font(.headline)

                    Text("\(observatory.city), \(observatory.state)")
                        .font(.subheadline)
                }
                .padding()
                .padding(.vertical, -10)

                HStack{
                    Image(systemName: "gearshape.fill")
                    Text("Tecnologias disponíveis")
                        .font(.headline)
                }
                .padding()
                .padding(.vertical, -10)

                HStack{
                    Image(systemName: "star.fill")
                    Text("Destaque científico")
                        .font(.headline)
                }
                .padding()
                .padding(.vertical, -10)

                HStack{
                    Image(systemName: "person.2.fill")
                    Text("Visitação")
                        .font(.headline)
                }
                .padding()
                .padding(.vertical, -10)

                Spacer()
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

import SwiftUI
import MapKit

struct ObservatoriesView: View {
    @StateObject private var locationManager = LocationManager() // Adiciona o LocationManager
    let allObservatories = [
        Observatory(name: "Observatório Abrahão de Moraes",
                  coordinate: CLLocationCoordinate2D(latitude: -23.0063817758379, longitude: -46.963540446073466),
                  city: "Valinhos",
                  state: "São Paulo"),
        Observatory(name: "Observatório Municipal de Campinas 'Jean Nicolini'",
                  coordinate: CLLocationCoordinate2D(latitude: -22.900736147804764, longitude: -46.82637550404957),
                  city: "Campinas",
                  state: "São Paulo"),
        Observatory(name: "Observatório Municipal de Americana",
                  coordinate: CLLocationCoordinate2D(latitude: -22.757266042526126, longitude: -47.35329532690401),
                  city: "Americana",
                  state: "São Paulo"),
        Observatory(name: "Polo Astronômico de Amparo",
                  coordinate: CLLocationCoordinate2D(latitude: -22.77501696953554, longitude: -46.72219052779235),
                  city: "Amparo",
                  state: "São Paulo")
    ]
    
    @State private var searchText = ""
    @State private var selectedObservatory: Observatory?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -22.911304857516285, longitude: -47.06560557293485),
        span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    )
    
    private var filteredObservatories: [Observatory] {
        if searchText.isEmpty {
            return allObservatories
        } else {
            return allObservatories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.state.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Barra de pesquisa
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                // Mapa com pins
                Map(coordinateRegion: $region,
                    annotationItems: filteredObservatories) { observatory in
                    MapAnnotation(coordinate: observatory.coordinate) {
                        VStack(spacing: 0) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                                .onTapGesture {
                                    selectedObservatory = observatory
                                    withAnimation {
                                        region.center = observatory.coordinate
                                        region.span = MKCoordinateSpan(
                                            latitudeDelta: 0.04,
                                            longitudeDelta: 0.04
                                        )
                                    }
                                }

                            Text(observatory.name)
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
                        region.center = first.coordinate
                        region.span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
                    }
                }
                
                // Lista de observatórios
                List(filteredObservatories) { observatory in
                    VStack(alignment: .leading) {
                        Text(observatory.name)
                            .font(.headline)
                        Text("\(observatory.city), \(observatory.state)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectedObservatory = observatory
                        withAnimation {
                            region.center = observatory.coordinate
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
    }
}
