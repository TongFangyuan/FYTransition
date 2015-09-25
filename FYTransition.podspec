
Pod::Spec.new do |s|

s.name = 'FYTransition'
s.version = '0.0.2'
s.summary = 'A custom transition used on iOS.'
s.homepage = 'https://github.com/TongFangyuan/FYTransition'
s.license = 'MIT'
s.authors = {'MJ Lee' => '573682532@qq.com'}
s.platform = :ios, '5.0'
s.source = {:git => 'https://github.com/TongFangyuan/FYTransition.git', :tag => s.version}
s.source_files = 'FYTransition/**/*.{h,m}'
s.requires_arc = true

end