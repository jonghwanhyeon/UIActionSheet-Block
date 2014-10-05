Pod::Spec.new do |s|
  s.name         = "UIActionSheet+Block"
  s.version      = "1.0.2"
  s.summary      = "UIActionSheet category to replace UIUIActionSheetDelegate by block"
  s.homepage     = "https://github.com/hyeon0145/UIActionSheet-Block.git"
  s.license      = { :type => 'WTFPL', :file => 'LICENSE' }
  s.author       = { "Jonghwan Hyeon" => "hyeon0145@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/hyeon0145/UIActionSheet-Block.git", :tag => "v#{s.version.to_s}" }
  s.source_files = "UIActionSheet+Block.{h,m}"
  s.requires_arc = true
end
