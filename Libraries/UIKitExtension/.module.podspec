base_dir = ""

Pod::Spec.new do |spec|
  spec.name = "UIKitExtension"
  spec.version = "0.0.1"
  spec.summary = "Description of library"

  spec.homepage = "https://github.com/RioRizkyRainey/DBL-Play.git"
  spec.license = "MIT"
  spec.author = { "Ruangguru iOS Team" => "ios-team@ruangguru.com" }

  spec.platform = :ios, "11.0"
  spec.swift_version = "5.0"
  
  spec.source = {
    :git => "https://github.com/RioRizkyRainey/DBL-Play.git",
    :branch => "master",
  }

  spec.source_files = "#{base_dir}Source", "#{base_dir}Source/**/*.{swift}"
  spec.public_header_files = "#{base_dir}Source/**/*.h"
  spec.exclude_files = "#{base_dir}UnitTests", "#{base_dir}Demo"
  spec.resources = ""

end
