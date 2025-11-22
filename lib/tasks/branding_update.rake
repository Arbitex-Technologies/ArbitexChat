namespace :branding do
  desc 'Update branding configuration to ArbitexChat'
  task update: :environment do
    puts 'Updating branding configuration...'
    
    branding_configs = {
      'INSTALLATION_NAME' => 'ArbitexChat',
      'BRAND_NAME' => 'ArbitexChat',
      'BRAND_URL' => 'https://arbitexcorp.com',
      'WIDGET_BRAND_URL' => 'https://arbitexcorp.com',
      'TERMS_URL' => 'https://arbitexcorp.com/terms-of-service',
      'PRIVACY_URL' => 'https://arbitexcorp.com/privacy-policy'
    }
    
    branding_configs.each do |name, value|
      config = InstallationConfig.find_by(name: name)
      if config
        old_value = config.value
        config.update(value: value)
        puts "✓ Updated #{name}: '#{old_value}' → '#{value}'"
      else
        InstallationConfig.create(name: name, value: value, locked: false)
        puts "✓ Created #{name}: '#{value}'"
      end
    end
    
    # Clear cache to ensure changes take effect immediately
    GlobalConfig.clear_cache
    puts "\n✓ Cache cleared"
    puts "\nBranding update completed!"
  end
end

