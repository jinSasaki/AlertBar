Pod::Spec.new do |s|
  s.name             = "AlertBar"
  s.version          = "0.4.0"
  s.summary          = "An easy alert on status bar."
  s.homepage         = "https://github.com/jinSasaki/AlertBar"
  s.screenshots      = "https://github.com/jinSasaki/AlertBar/raw/master/assets/demo.gif"
  s.license          = 'MIT'
  s.author           = { "Jin Sasaki" => "aysm47@gmail.com" }
  s.source           = { :git => "https://github.com/jinSasaki/AlertBar.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sasakky_j'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Sources/**/*'
end
