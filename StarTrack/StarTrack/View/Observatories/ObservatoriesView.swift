import SwiftUI
import MapKit

struct Observatory: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let city: String
    let country: String
}

struct ObservatoriesView: View {
    // Dados de exemplo - substitua com seus dados reais
    let allObservatories = [
        Observatory(name: "Observatório do Mauna Kea",
                  coordinate: CLLocationCoordinate2D(latitude: 19.8236, longitude: -155.4694),
                  city: "Hilo",
                  country: "Estados Unidos"),
        Observatory(name: "Observatório Paranal",
                  coordinate: CLLocationCoordinate2D(latitude: -24.6272, longitude: -70.4042),
                  city: "Antofagasta",
                  country: "Chile"),
        Observatory(name: "Observatório Roque de los Muchachos",
                  coordinate: CLLocationCoordinate2D(latitude: 28.7606, longitude: -17.8796),
                  city: "Santa Cruz de Tenerife",
                  country: "Espanha"),
        Observatory(name: "Observatório Siding Spring",
                  coordinate: CLLocationCoordinate2D(latitude: -31.2728, longitude: 149.0717),
                  city: "Coonabarabran",
                  country: "Austrália")
    ]
    
    @State private var searchText = ""
    @State private var selectedObservatory: Observatory?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    )
    
    private var filteredObservatories: [Observatory] {
        if searchText.isEmpty {
            return allObservatories
        } else {
            return allObservatories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText) ||
                $0.country.localizedCaseInsensitiveContains(searchText)
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
                                            latitudeDelta: 2,
                                            longitudeDelta: 2
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
                    // Centraliza o mapa no primeiro observatório ao carregar
                    if let first = allObservatories.first {
                        region.center = first.coordinate
                        region.span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
                    }
                }
                
                // Lista de observatórios
                List(filteredObservatories) { observatory in
                    VStack(alignment: .leading) {
                        Text(observatory.name)
                            .font(.headline)
                        Text("\(observatory.city), \(observatory.country)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        selectedObservatory = observatory
                        withAnimation {
                            region.center = observatory.coordinate
                            region.span = MKCoordinateSpan(
                                latitudeDelta: 2,
                                longitudeDelta: 2
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
                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
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
                    
                    Text("\(observatory.city), \(observatory.country)")
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
