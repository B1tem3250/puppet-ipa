define ipa::replicaprepare (
  $host = $name,
  $dspw = {}
) {

  Cron["k5start_root"] -> Exec["replicaprepare-${host}"] ~> Exec["replica-info-scp-${host}"] ~> Ipa::Hostdelete[$host]

  $file = "/var/lib/ipa/replica-info-${host}.gpg"

  cron {
    "k5start_root":
      command => "/usr/bin/k5start -f /etc/krb5.keytab -U -o root -k /tmp/krb5cc_0 > /dev/null 2>&1",
      user    => 'root',
      minute  => "*/1",
      require => Package["kstart"],
  }

  exec {
    "replicaprepare-${host}":
      command => "/usr/sbin/ipa-replica-prepare --password=${dspw} ${host}",
      unless  => "/usr/sbin/ipa-replica-manage --password=${dspw} list | /bin/grep ${host} >/dev/null 2>&1",
      timeout => '0';

    "replica-info-scp-${host}":
      command     => "/usr/bin/scp -q -o 'StrictHostKeyChecking no' -o 'GSSAPIAuthentication yes' -o 'ConnectTimeout 5' -o 'ServerAliveInterval 2' ${file} root@${host}:${file}",
      refreshonly => true,
      tries       => '60',
      try_sleep   => '60',
  }

  ipa::hostdelete {
    $host:
  }
}
