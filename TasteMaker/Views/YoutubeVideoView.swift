import SwiftUI
import WebKit

struct YoutubeVideoView: View {
    var videoID: String?
    @State var isLoading: Bool
    
    init(urlString: String?, isLoading: Bool = false) {
        guard let urlString,
              let urlComponents = URLComponents(string: urlString),
              let queryItems = urlComponents.queryItems,
              let videoID = queryItems.first(where: { $0.name == "v" })?.value else {
            self.isLoading = false
            return
        }
        self.videoID = videoID
        self.isLoading = isLoading
    }
    
    var body: some View {
        ZStack {
            if let videoID {
                ZStack {
                    YoutubeVideoViewRep(videoID: videoID, isLoading: $isLoading)
                    if isLoading {
                        ProgressView()
                    }
                }
            } else {
                Color.gray
                    .opacity(0.3)
            }
        }
        .clipShape(.rect(cornerRadius: 10))
        .frame(width: 300, height: 200)
    }
}

private struct YoutubeVideoViewRep: UIViewRepresentable {
    var videoID: String
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        let path = "https://www.youtube.com/embed/\(videoID)"
        if let url = URL(string: path) {
            webView.scrollView.isScrollEnabled = false
            webView.load(.init(url: url))
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YoutubeVideoViewRep

        init(parent: YoutubeVideoViewRep) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}


#Preview("Normal") {
    YoutubeVideoView(urlString: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
}

#Preview("Video not found") {
    YoutubeVideoView(urlString: "")
}
