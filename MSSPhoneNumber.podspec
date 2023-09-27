Pod::Spec.new do |s|
  s.name             = 'MSSPhoneNumber'
  s.version          = '1.0.0'
  s.summary          = 'MSSPhoneNumber is a Swift framework designed for international phone number validation with built-in support for selecting country codes.'

  s.homepage         = 'https://github.com/skaik-mo/MSSPhoneNumber'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'skaik-mo' => 'mohamedsaeb.skaik@gmail.com' }
  s.source           = { :git => 'https://github.com/skaik-mo/MSSPhoneNumber.git', :tag => s.version.to_s }

  s.source_files = 'Sources/**/*'
  s.resources = 'Sources/MSSPhoneNumber/*'

  s.ios.deployment_target = '13.0'
  s.swift_versions = "5.0"


end
