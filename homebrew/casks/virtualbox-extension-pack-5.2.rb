cask 'virtualbox-extension-pack-5.2' do

  version '5.2.22'
  sha256 '779250666551b2f5426e86c2d21ceb0209b46174536971611025f753535131ef'

  url "https://download.virtualbox.org/virtualbox/#{version}/Oracle_VM_VirtualBox_Extension_Pack-#{version}.vbox-extpack"

  name 'Oracle VirtualBox Extension Pack 5.2 (fixed version)'
  homepage 'https://www.virtualbox.org/'

  conflicts_with cask: 'virtualbox-extension-pack-beta'
  depends_on cask: 'virtualbox'
  container type: :naked

  stage_only true

  postflight do
    system_command '/usr/local/bin/VBoxManage',
                   args:  [
                            'extpack', 'install',
                            '--replace', "#{staged_path}/Oracle_VM_VirtualBox_Extension_Pack-#{version}.vbox-extpack"
                          ],
                   input: 'y',
                   sudo:  true
  end

  uninstall_postflight do
    next unless File.exist?('/usr/local/bin/VBoxManage')

    system_command '/usr/local/bin/VBoxManage',
                   args: [
                           'extpack', 'uninstall',
                           'Oracle VM VirtualBox Extension Pack'
                         ],
                   sudo: true
  end

  caveats do
    license 'https://www.virtualbox.org/wiki/VirtualBox_PUEL'
  end
end
