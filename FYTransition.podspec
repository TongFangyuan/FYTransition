Pod::Spec.new do |s|
s.name             = "FYTransition"
s.version          = "1.0.0"
s.summary          = "A custom transition used on iOS."
s.description      = <<-DESC
It is a custom transition used on iOS, which implement by Objective-C.
DESC
s.homepage         = "https://github.com/TongFangyuan/FYTransition"
# s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
s.license          = 'MIT'
s.author           = { "Tony" => "573682532@qq.com" }
s.source           = { :git => "https://github.com/TongFangyuan/FYTransition.git", :tag => s.version.to_s }
# s.social_media_url = 'http://weibo.com/u/2672244005'

s.platform     = :ios, '8.0'
# s.ios.deployment_target = '8.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true

s.source_files = 'FYTransition/*'
# s.resources = 'Assets'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end