# frozen_string_literal: true

title 'phpstorm archives profile'

control 'phpstorm archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/phpstorm.sh') do
    it { should exist }
  end
  # describe file('/usr/local/jetbrains/phpstorm-*/bin/phpstorm.sh') do
  #   it { should exist }
  # end
  describe file('/usr/share/applications/phpstorm.desktop') do
    it { should exist }
  end
  describe file('/usr/local/bin/phpstorm') do
    it { should exist }
  end
end
