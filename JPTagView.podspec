

Pod::Spec.new do |s|

  s.name         = "JPTagView"
  s.version      = "1.6.0"
  s.summary      = "Customized tag pages."
  s.homepage     = "https://github.com/baiyidjp/JPTagViewDemo"
  s.license      = "MIT"
  s.author             =  "baiyi"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/baiyidjp/JPTagViewDemo.git", :tag => "#{s.version}" }
  s.source_files  = "JPTagView/*.{h,m}"
  s.requires_arc = true
  s.dependency "SDWebImage"
  # s.dependency 'JPCategory-OC/UIView', '1.2.3'
  # s.dependency 'JPCategory-OC/UIImage', '1.2.3'
  s.dependency 'JPCategory-OC/UIView', :git => "https://github.com/baiyidjp/JPCategory-OC.git", :tag => '1.2.3'
  s.dependency 'JPCategory-OC/UIImage', :git => "https://github.com/baiyidjp/JPCategory-OC.git", :tag => '1.2.3'
# pod trunk push --allow-warnings
end
