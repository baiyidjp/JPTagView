

Pod::Spec.new do |s|

  s.name         = "JPTagView"
  s.version      = "1.3.1"
  s.summary      = "Customized tag pages."
  s.homepage     = "https://github.com/baiyidjp/JPTagView"
  s.license      = "MIT"
  s.author             =  "baiyi"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/baiyidjp/JPTagView.git", :tag => "#{s.version}" }
  s.source_files  = "JPTagView/*.{h,m}"
  s.requires_arc = true
# pod trunk push --allow-warnings
end
