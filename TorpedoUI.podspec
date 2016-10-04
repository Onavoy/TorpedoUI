Pod::Spec.new do |s|
  s.name = 'TorpedoUI'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'UIKit on Crack'
  s.homepage = 'https://github.com/Onavoy/TorpedoUI'
  s.authors = { 'Hisham Alabri' => 'hisham@alabri.co' }
  s.source = { :git => 'https://github.com/Onavoy/TorpedoUI.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  #s.osx.deployment_target = '10.11'
  #s.tvos.deployment_target = '9.0'
  #s.watchos.deployment_target = '2.0'

  s.source_files = 'TorpedoUI/Classes/**/*.swift'
end