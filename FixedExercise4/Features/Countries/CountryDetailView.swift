//
//  CountryDetailView.swift
//  FixedExercise4
//
//  Created by Lukas Brezina on 30.09.26.
//
import SwiftUI

struct CountryDetailView: View {

    let country: Country
    private var countryFields: CountryFields { country.fields }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                header()

                row("Capital", countryFields.capital.stringValue)
                row("Continent", countryFields.continent.stringValue)
                row("Currency", countryFields.currency.stringValue)
                row("Phone", "+\(countryFields.phone.stringValue)")
                
                languages()
            }
            .padding()
        }
        .navigationTitle(countryFields.name.stringValue)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func row(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .font(.title3)
                .bold()
            Spacer()
            Text(value)
                .bold()
        }
    }
    
    private func header() -> some View {
        VStack(spacing: 4) {
            Text(countryFields.name.stringValue)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Text(countryFields.native.stringValue)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.gray.opacity(0.3))
    }
    
    private func languages() -> some View {
        VStack(spacing: 8) {
            Text("Languages")
                .font(.title3)
                .bold()

            LazyVStack(spacing: 8) {
                ForEach(countryFields.languages.arrayValue.values, id: \.stringValue) { language in
                    Text(language.stringValue)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.2), in: Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
