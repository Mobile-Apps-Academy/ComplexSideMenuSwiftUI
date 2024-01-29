//
// Created By: Mobile Apps Academy
// Subscribe : https://www.youtube.com/@MobileAppsAcademy?sub_confirmation=1
// Medium Blob : https://medium.com/@mobileappsacademy
// LinkedIn : https://www.linkedin.com/company/mobile-apps-academy
// Twitter : https://twitter.com/MobileAppsAcdmy
// Lisence : https://github.com/Mobile-Apps-Academy/MobileAppsAcademyLicense/blob/main/LICENSE.txt
//

import SwiftUI

struct ContentView: View {
    @State var index = 0
    @State var showSideMenu = false
    
    var body: some View {
        ZStack {
            HStack{
                VStack(alignment: .leading, spacing: 12) {
                    SideMenu()
                }
                .padding(.top,25)
                .padding(.horizontal,20)
                Spacer(minLength: 0)
            }
            
            VStack(spacing: 0){
                Header()
                Pages().shadow(radius: 20)
            }
            .background(.black)
            .cornerRadius(self.showSideMenu ? 30 : 0)
            .scaleEffect(self.showSideMenu ? 0.9 : 1)
            .offset(x: self.showSideMenu ? UIScreen.main.bounds.width / 2 : 0, y: self.showSideMenu ? 15 : 0)
            .rotationEffect(.init(degrees: self.showSideMenu ? -5 : 0))
        }
        .shadow(radius: 20)
        .ignoresSafeArea(edges: .bottom)
        .background(self.showSideMenu ? Color.white : .black)
    }
    
    @ViewBuilder
    private func SideMenu() -> some View {
        SideMenuHeader()
        SideMenuListButton(buttonText: "Catalouge", icon: "catalogue", index: 0)
        SideMenuListButton(buttonText: "Cart", icon: "cart", index: 1)
        SideMenuListButton(buttonText: "Favourites", icon: "favorite", index: 2)
        SideMenuListButton(buttonText: "Your Orders", icon: "orders", index: 3)
        Divider()
            .frame(width: 150, height: 1)
            .background(Color.black)
            .padding(.vertical,30)
        
        LogoutButton()
        Spacer()
    }
    
    @ViewBuilder
    private func SideMenuListButton(buttonText: String, icon: String, index: Int) -> some View {
        Button(action: {
            self.index = index
            withAnimation{
                self.showSideMenu.toggle()
            }
        }) {
            HStack(spacing: 15){
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .colorMultiply(self.index == index ? .yellow : Color.black)

                Text(buttonText)
                    .bold(self.index == index)
                    .foregroundColor(self.index == index ? .yellow : Color.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(self.index == index ? .black : Color.clear)
            .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    private func SideMenuHeader() -> some View {
        Image("profile")
            .resizable()
            .frame(width: 100, height: 100)
            .colorInvert()
        
        Text("Hey")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.top, 10)
        
        Text("Catherine")
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.black)
    }
    
    @ViewBuilder
    private func LogoutButton() -> some View {
        Button(action: {}) {
            HStack(spacing: 25){
                Image("logout")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .colorMultiply(Color.black)

                Text("Sign Out")
                .foregroundColor(Color.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func Pages() -> some View {
        GeometryReader{_ in
            VStack{
                switch self.index {
                case 0:
                    HomePage()
                        
                case 1:
                    Cart()
                case 2:
                    Favourites()
                default:
                    Orders()
                }
            }
        }
    }
    
    @ViewBuilder
    private func Header() -> some View {
        HStack(spacing: 15){
            Button(action: {
                withAnimation{
                    self.showSideMenu.toggle()
                }
            }) {
                Image(systemName: self.showSideMenu ? "xmark" : "line.horizontal.3")
                    .resizable()
                    .frame(width: self.showSideMenu ? 18 : 22, height: 18)
                    .foregroundColor(.white)
            }
            
            Text(self.index == 0 ? "Home" : (self.index == 1 ? "Cart" : (self.index == 2 ? "Favourites" : "Orders")))
                .font(.title)
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}


struct HomePage: View {
    var body: some View {
        ZStack {
            VStack {
                HeroImage()
                ProductList()
            }
        }
        .background(.black)
    }

    @ViewBuilder
    private func HeroImage() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .frame(width: 400, height: 400)
                .foregroundStyle(.white.opacity(0.5))
                .offset(CGSize(width: 100.0, height: 10.0))
                .overlay(alignment: .bottomTrailing)  {
                    Button(action: {}, label: {
                        HStack(spacing: nil, content: {
                            Spacer()
                            RoundedRectangle(cornerRadius: 35.0)
                                .frame(width: 80, height: 80)
                                .foregroundStyle(.white)
                                .overlay {
                                    Image("cart")
                                        .resizable()
                                        .colorMultiply(.black)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                }
                        })
                    })
                    .offset(CGSize(width: -20, height: 50.0))
                }
            
            VStack(spacing: -40) {
                Image("helmet 3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .offset(CGSize(width: 0, height: -30.0))
                VStack(alignment: .leading) {
                    Text("Bell Local Helmet")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .bold()
                    Text("Orange Cycle Helmet")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    Divider()
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    @ViewBuilder
    private func ProductList() -> some View {
        VStack {
            Product(productName: "Xiaomi Ninebot", productCaption: "Black scooter helmet", image: "helmet 2")
            Product(productName: "Unbranded Helmet", productCaption: "Urban cycling helmet", image: "helmet 1")
        }
        .padding(.top, 30)
    }
    
    @ViewBuilder
    private func Product(productName: String, productCaption: String, image: String) -> some View {
        
        Button(action: {}, label: {
            HStack(alignment: .center, spacing: 30) {
                
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width: 100, height: 130)
                    .foregroundStyle(.white.opacity(0.5))
                    .overlay(alignment: .center)  {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 110, height: 110)
                    }
                
                VStack(alignment: .leading) {
                    
                    Text(productName)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .bold()

                    Text(productCaption)
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .opacity(0.3)
                   
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 20)
            
        })
    }
}

struct Cart : View {
    var body: some View{
        VStack(alignment: .center){
            Text("Cart")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Orders : View {
    var body: some View{
        VStack(alignment: .center){
            Text("Orders")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Favourites : View {
    var body: some View{
        VStack(alignment: .center){
            Text("Favourites")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
