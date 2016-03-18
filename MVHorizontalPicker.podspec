Pod::Spec.new do |s|
  s.name         = 'MVHorizontalPicker'
  s.version      = '0.0.1'
  s.summary      = 'Simple scrollable horizontal control, alternative to UISegmentedControl'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/bizz84/MVHorizontalPicker'
  s.author       = { 'Andrea Bizzotto' => 'bizz84@gmail.com' }
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/bizz84/MVHorizontalPicker.git", :tag => s.version }

  s.source_files = 'MVHorizontalPicker/*.{swift,xib}'

  s.requires_arc = true
end
