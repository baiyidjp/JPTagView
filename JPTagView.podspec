

Pod::Spec.new do |s|

  s.name         = "JPTagView"
  s.version      = "1.5.1"
  s.summary      = "Customized tag pages."
  s.homepage     = "https://github.com/baiyidjp/JPTagViewDemo"
  s.license      = "MIT"
  s.author             =  "baiyi"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/baiyidjp/JPTagViewDemo.git", :tag => "#{s.version}" }
  s.source_files  = "JPTagView/*.{h,m}"
  s.requires_arc = true
  s.dependency "SDWebImage"
# pod trunk push --allow-warnings
# 将修改文件copy到JPTagView
end
