Pod::Spec.new do |s| 
  s.name = 'CharStatusBarView'
  s.version = '0.0.1'
  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.prefix_header_file = 'CharStatusBarView/CharStatusBarView-Prefix.pch'
  s.source_files = 'CharStatusBarView/views/*.{h,m,c}'
  s.requires_arc = true
end
