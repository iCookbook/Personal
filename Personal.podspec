Pod::Spec.new do |s|
  s.name             = 'Personal'
  s.version          = '0.1.0'
  s.summary          = '\'Personal\' module.'
  s.homepage         = 'https://github.com/iCookbook/Personal'
  s.author           = { 'htmlprogrammist' => '60363270+htmlprogrammist@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/iCookbook/Personal.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'Personal/**/*.{swift}'
  
  s.dependency 'CommonUI'
  s.dependency 'Resources'
  s.dependency 'Persistence'
  s.dependency 'Logger'
end
