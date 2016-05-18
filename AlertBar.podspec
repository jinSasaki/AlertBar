Pod::Spec.new do |s|
  s.name             = "AlertBar"
  s.version          = "0.1.3"
  s.summary          = "An easy alert on status bar."
  s.homepage         = "https://github.com/jinSasaki/AlertBar"
  s.screenshots      = "https://github.com/jinSasaki/AlertBar/raw/master/etc/demo.gif"
  s.license          = 'MIT'
  s.author           = { "Jin Sasaki" => "aysm47@gmail.com" }
  s.source           = { :git => "https://github.com/jinSasaki/AlertBar.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sasakky_j'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'AlertBar' => ['Pod/Assets/*.png']
  }
end
