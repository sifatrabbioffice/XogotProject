import SwiftUI

@main
struct XogotApp: App {
    var body: some Scene {
        WindowGroup {
            EditorMainView()
                .preferredColorScheme(.dark)
        }
    }
}

// 1. C++ ইঞ্জিনের সাথে SwiftUI-র ব্রিজ (ব্রিজ ফোল্ডারের ক্লাসকে কল করবে)
struct GodotEngineRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> GodotEngineView {
        return GodotEngineView(frame: .zero)
    }
    func updateUIView(_ uiView: GodotEngineView, context: Context) {}
}

// 2. Editor Main View (সব UI যুক্ত করা হলো)
struct EditorMainView: View {
    var body: some View {
        ZStack {
            // ----------> C++ গডট ইঞ্জিনের জন্য জায়গা <----------
            GodotEngineRepresentable()
                .ignoresSafeArea()
            
            // ----------> SwiftUI UI ওভারলেয় (সবকিছু ইঞ্জিনের ওপরে) <----------
            VStack(spacing: 0) {
                // 1. Top Header
                HStack(spacing: 14) {
                    HStack(spacing: 6) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(white: 0.15))
                            .frame(width: 28, height: 28)
                            .overlay(Image(systemName: "video.fill").font(.system(size: 12)).foregroundColor(.white))
                        
                        Text("Xogot").font(.headline).fontWeight(.bold).foregroundColor(.white)
                        Image(systemName: "chevron.down").font(.system(size: 10)).foregroundColor(.gray)
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        CircularButton(icon: "doc.text")
                        CircularButton(icon: "target")
                        CircularButton(icon: "play.fill", bgColor: .white.opacity(0.15))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                
                // 2. Editor Toolbar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ToolIcon(icon: "arrow.up.left.and.arrow.down.right", active: true)
                        ToolIcon(icon: "arrow.up.and.down.and.arrow.left.and.right")
                        ToolIcon(icon: "rotate.3d")
                        ToolIcon(icon: "arrow.up.left.and.arrow.down.right.magnifyingglass")
                        Divider().frame(height: 16).background(Color.gray.opacity(0.4))
                        ToolIcon(icon: "list.bullet")
                        ToolIcon(icon: "lock")
                        ToolIcon(icon: "square.dashed")
                        ToolIcon(icon: "cube")
                        Divider().frame(height: 16).background(Color.gray.opacity(0.4))
                        ToolIcon(icon: "sun.max")
                        ToolIcon(icon: "globe")
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                }
                .padding(.top, 4)
                .background(Color(white: 0.08))
                
                // 3. Perspective Dropdown
                HStack(spacing: 12) {
                    Image(systemName: "rectangle.dashed").font(.system(size: 14)).foregroundColor(.gray)
                    Text("Perspective").font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                    Spacer()
                    Image(systemName: "house.fill").font(.system(size: 14)).foregroundColor(.white)
                    Image(systemName: "square.3.layers.3d").font(.system(size: 14)).foregroundColor(.white)
                }
                .padding(.horizontal, 14).padding(.vertical, 8)
                .background(Capsule().fill(Color(white: 0.22)))
                .padding(.top, 10).padding(.horizontal, 16)
                
                Spacer() // মাঝখানে ফাঁকা জায়গা
            }
            
            // 4. 3D Gizmo
            VStack {
                Spacer().frame(height: 130)
                HStack {
                    Spacer()
                    ZStack {
                        VStack {
                            HStack(spacing: 0) {
                                Text("Y").foregroundColor(.green).offset(y: -12)
                                Spacer().frame(width: 30)
                            }
                            HStack(spacing: 14) {
                                Text("Z").foregroundColor(.blue)
                                Circle().fill(Color.white.opacity(0.08)).frame(width: 26, height: 26)
                                Text("X").foregroundColor(.red).offset(y: 12)
                            }
                        }
                    }
                    .padding(.trailing, 16)
                }
                Spacer()
            }
            
            // 5. Floating Buttons
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(spacing: 12) {
                        FloatingActionButton(icon: "arrow.uturn.left.circle.fill", tint: .blue)
                        FloatingActionButton(icon: "arrow.uturn.right.circle.fill", tint: .gray)
                    }
                    Spacer()
                    VStack(spacing: 12) {
                        FloatingTextButton(text: "3D", tint: .blue)
                        FloatingTextButton(text: "2D", tint: .gray)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 130)
            }
            
            // 6. Custom Bottom Tab Bar
            VStack {
                Spacer()
                XogotBottomTabBar()
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
            }
        }
    }
}

// ==========================================
// MARK: - UI Components
// ==========================================
struct XogotBottomTabBar: View {
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                TabButton(icon: "wrench.fill", label: "Editor", active: true)
                TabButton(icon: "doc.text.fill", label: "Code", active: false)
                TabButton(icon: "gamecontroller.fill", label: "Play", active: false)
            }
            .padding(4)
            .background(Capsule().fill(Color(white: 0.15)))
            Spacer().frame(width: 14)
            Button(action: {}) {
                Image(systemName: "magnifyingglass").font(.system(size: 18, weight: .medium)).foregroundColor(.white)
                    .frame(width: 44, height: 44).background(Circle().fill(Color(white: 0.15)))
            }
        }
    }
    
    @ViewBuilder
    func TabButton(icon: String, label: String, active: Bool) -> some View {
        Button(action: {}) {
            VStack(spacing: 2) {
                Image(systemName: icon).font(.system(size: 18, weight: .medium))
                Text(label).font(.caption2).fontWeight(.medium)
            }
            .frame(width: 70, height: 42)
            .foregroundColor(active ? .blue : .white)
            .background(active ? Capsule().fill(Color.white.opacity(0.1)) : nil)
        }
    }
}
struct CircularButton: View {
    let icon: String
    var bgColor: Color = Color(white: 0.12)
    var body: some View {
        Image(systemName: icon).font(.system(size: 16)).foregroundColor(.white)
            .frame(width: 34, height: 34).background(Circle().fill(bgColor))
    }
}
struct ToolIcon: View {
    let icon: String
    var active: Bool = false
    var body: some View {
        Image(systemName: icon).font(.system(size: 15))
            .foregroundColor(active ? .blue : .white)
            .padding(6).background(active ? Color.blue.opacity(0.15) : Color.clear).cornerRadius(4)
    }
}
struct FloatingActionButton: View {
    let icon: String; let tint: Color
    var body: some View {
        Image(systemName: icon).font(.system(size: 22)).foregroundColor(tint)
            .frame(width: 40, height: 40).background(Color(white: 0.12)).clipShape(Circle())
    }
}
struct FloatingTextButton: View {
    let text: String; let tint: Color
    var body: some View {
        Text(text).font(.system(size: 16, weight: .semibold)).foregroundColor(tint)
            .frame(width: 40, height: 40).background(Color(white: 0.12)).clipShape(Circle())
    }
}
