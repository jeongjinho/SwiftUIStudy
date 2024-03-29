//
//  LayoutAndStacks.swift
//  SwiftUIBoot
//
//  Created by jeong jinho on 2022/12/12.
//

import SwiftUI

struct LayoutAndStacks: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomStsate = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ?  20 : 0)
                .opacity( showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatForever(autoreverses: true)
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ?  Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y:  show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(Angle(degrees: showCard ? -10: 0))
                .rotationEffect(Angle(degrees: show ? 0 : 10))
                .rotation3DEffect(.degrees( showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.5), value: show)
                .animation(.easeOut(duration: 0.5), value: showCard)
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ?  Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle(degrees: showCard ? -5: 0))
                .rotationEffect(Angle(degrees: show ? 0 : 5 ))
                .rotation3DEffect(.degrees( showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.3), value: show)
                .animation(.easeOut(duration: 0.5), value: showCard)
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20,style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.0), value: viewState)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.0), value: showCard)
                .onTapGesture {
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            self.viewState = value.translation
                            self.show = true
                        })
                        .onEnded({ value in
                            self.viewState = .zero
                            self.show = false
                        })
                )
                
            
            Text("Value \(bottomStsate.height), bool \(self.showFull.description)")
                .offset(y: -350)
            
            
            BottomCardView(show: $showCard)
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomStsate.height)
                .blur(radius: show ? 20 : 0)
               .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: showCard)
                .gesture(DragGesture()
                    .onChanged({ value in
                        self.bottomStsate = value.translation
                        if self.showFull {
                            self.bottomStsate.height += -300
                        }
                        
                        if self.bottomStsate.height < -300 {
                            self.bottomStsate.height = -300
                        }
                        
                    }).onEnded({ value in
                        
                        if self.bottomStsate.height > 50 {
                            self.showCard = false
                        }
                        if (self.bottomStsate.height < -100  && !self.showFull) || (self.bottomStsate.height < -250 && self.showFull) {
                            self.bottomStsate.height = -300
                            self.showFull = true
                        } else {
                            self.bottomStsate = .zero
                            self.showFull = false
                        }
                        
                    }))
            
        }
       
    }
}

struct LayoutAndStacks_Previews: PreviewProvider {
    static var previews: some View {
        LayoutAndStacks()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
       
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
      
       // .offset(x: 0.0, y: -20.0)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            
            
            Text("This certificate is proof that Meng To has achived the UI Design course with approval from a  Design+Cod instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n10 hours spend to far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y:10)
            }
                
              
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}
