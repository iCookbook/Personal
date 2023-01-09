Pod::Spec.new do |s|
  s.name             = 'Personal'
  s.version          = '2.0.1'
  s.summary          = '\'Personal\' module.'
  s.homepage         = 'https://github.com/iCookbook/Personal'
  s.screenshots     = 'https://user-images.githubusercontent.com/60363270/210759369-b3be228f-ec45-419d-9770-900a27dad693.png',
                      'https://user-images.githubusercontent.com/60363270/210759393-32d3f9f2-26bf-4ff1-ae5e-8f042857deaa.png'
  s.author           = { 'htmlprogrammist' => '60363270+htmlprogrammist@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/iCookbook/Personal.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'

  s.source_files = 'Personal/Sources/**/*.{swift}'
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Personal/Tests/**/*.{swift}'
  end
  
  s.dependency 'CommonUI'
  s.dependency 'Resources'
  s.dependency 'Persistence'
  s.dependency 'Logger'
  
  s.dependency 'RecipeDetails'
  s.dependency 'RecipeForm'
end
