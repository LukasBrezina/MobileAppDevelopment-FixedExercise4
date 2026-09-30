//
//  CountriesView.swift
//  FixedExercise4
//
//  Created by Lukas Brezina on 28.09.26.
//
import SwiftUI

struct CountriesView: View {

    @State
    private var countries: [Country]?
    
    @State
    private var alert: AlertInfo?
    
    @State
    private var isLoading = false

    let loginIdToken: String
    
    private let minHeight: CGFloat = 40

    var body: some View {
        VStack {
            Text("Countries")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, minHeight: minHeight)
                .padding(24)
                .bold()

            if isLoading {
                ProgressView()
                    .frame(maxHeight: .infinity)
            } else if let countries {
                List(countries, id: \.name) { country in
                    NavigationLink(country.fields.name.stringValue) {
                        CountryDetailView(country: country)
                    }
                }
            }
        }
        .onAppear { fetchCountries() }
        .infoAlert($alert)
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fetchCountries() {
        isLoading = true
        APIClient.shared.countries(loginIdToken: loginIdToken) { data, error in
            isLoading = false
            if let data {
                countries = data.documents
            } else if let error {
                alert = AlertInfo(message: error.message)
            }
        }
    }
}
