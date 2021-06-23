require 'spec_helper'

packages_list = %w(
  conntrack-tools
  ipset
  socat
)

packages_list.each do |installed|
  describe package("#{installed}"), :if => os[:family] == 'redhat' do
    it { should be_installed }
  end
end


module_list = %w(
  nf_conntrack
)

module_list.each do |module_enabled|
  describe kernel_module("#{module_enabled}") do
    it { should be_loaded }
  end
end

bin_file_list = %w(
  /usr/local/bin/kubectl
  /opt/cni/bin/bridge
  /opt/cni/bin/dhcp
  /opt/cni/bin/firewall
  /opt/cni/bin/host-device
  /opt/cni/bin/ipvlan
  /opt/cni/bin/macvlan
  /opt/cni/bin/ptp
  /opt/cni/bin/sbr
  /opt/cni/bin/static
  /opt/cni/bin/vlan
)

bin_file_list.each do |file_present|
  describe file("#{file_present}") do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('others') }
    it { should be_executable.by('owner') }
    it { should be_executable.by('group') }
    it { should be_executable.by('others') }
  end
end

conf_list = %w(
  /etc/cni/net.d/10-bridge.conf
  /etc/cni/net.d/99-loopback.conf
  /etc/containerd/config.toml
  /etc/systemd/system/containerd.service
)

conf_list.each do |file_present|
  describe file("#{file_present}") do
    it { should be_file }
    it { should be_mode 640 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_writable.by('owner') }
  end
end
