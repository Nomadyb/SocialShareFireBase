import UIKit

class GradientView: UIView {
	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupGradient()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupGradient()
	}

	private func setupGradient() {
		let gradientLayer = self.layer as! CAGradientLayer
		gradientLayer.colors = [
			UIColor(red: 0.81, green: 0.19, blue: 0.34, alpha: 1.0).cgColor,  // Başlangıç rengi (pembemsi kırmızı)
			UIColor(red: 0.49, green: 0.19, blue: 0.58, alpha: 1.0).cgColor,  // Orta rengi (mor)
			UIColor(red: 0.19, green: 0.58, blue: 0.74, alpha: 1.0).cgColor   // Bitiş rengi (turkuaz)
		]
		gradientLayer.locations = [0.0, 0.5, 1.0]
	}


}

extension UIColor {
	convenience init(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		var rgb: UInt64 = 0

		Scanner(string: hexSanitized).scanHexInt64(&rgb)

		let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
		let blue = CGFloat(rgb & 0x0000FF) / 255.0

		self.init(red: red, green: green, blue: blue, alpha: 1.0)
	}
}
