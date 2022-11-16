//
//  DetailsView.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct DetailsView: View {
    
    // MARK: - Public properties
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    mainImage
                }
                VStack {
                    missonName
                    Spacer().frame(height: 8.0)
                    missonCaption
                    Spacer().frame(height: 24.0)
                    VStack {
                        timer
                        launchDate
                    }
                }
                Spacer()
            }
            .padding(.top)
            HStack {
                Spacer().frame(width: 4.0)
                Image("location")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20.0)
                Spacer().frame(width: 4.0)
            }
            Spacer()
        }
        .background(Color.black.opacity(0.86))
    }
    
    // MARK: - Private properties
    
    private var mainImage: some View {
        return Image("test")
            .resizable()
            .scaledToFill()
            .frame(
                width: 200.0,
                height: 400.0
            )
            .clipped()
            .cornerRadius(20.0)
            .padding(.leading)
    }
    
    private var missonName: some View {
        return Text("Long March 6A | Unknown Payload")
            .foregroundColor(.white)
            .font(.title3)
            .underline()
            .bold()
    }
    
    private var missonCaption: some View {
        return Text("Taiyuan, People's Republic of China Launch Complex 9A")
            .foregroundColor(.white)
            .font(.caption2)
    }
    
    private var timer: some View {
        return Text("T+ 23 : 24 : 00")
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
    
    private var launchDate: some View {
        return Text("12/11/2022, 00:00:00")
            .foregroundColor(.white)
            .font(.caption2)
    }
    
}

struct DetailsView_Preview: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
