Pod::Spec.new do |s|

  s.name         = "JPTagView"
  s.version      = "1.6.6"
  s.summary      = "Customized tag pages."
  s.homepage     = "https://github.com/baiyidjp/JPTagView"
  s.license      = "MIT"
  s.author             =  "baiyi"
  s.ios.deployment_target = "9.0"
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.source       = { :git => "https://github.com/baiyidjp/JPTagView.git", :tag => "#{s.version}" }
  s.source_files  = "JPTagView/*.{h,m}"
  s.requires_arc = true
  s.dependency "SDWebImage"
  s.dependency 'JPCategory-OC/UIView'
  s.dependency 'JPCategory-OC/UIImage'
# pod trunk push --allow-warnings
end
