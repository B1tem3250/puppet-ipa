# == Class: ipa::params
#
# Defaults for ipa class.
#
# === Parameters
#
# === Variables
#
#
# === Examples
#
#
# === Authors
#
#
# === Copyright
#
#
class ipa::params {
  $master       = false
  $replica      = false
  $client       = false
  $cleanup      = false
  $domain       = undef
  $realm        = undef
  $adminpw      = undef
  $dspw         = undef
  $otp          = undef
  $dns          = false
  $mkhomedir    = false
  $ntp          = false
  $kstart       = true
  $desc         = ''
  $locality     = ''
  $location     = ''
  $sssdtools    = true
  $sssdtoolspkg = 'sssd-tools'
  $sssd         = true
  $sudo         = false
  $sudopw       = undef
  $automount    = false
  $autofs       = false
  $svrpkg       = 'ipa-server'
  $clntpkg      = $::osfamily ? {
    Debian  => 'freeipa-client',
    default => 'ipa-client',
  }
  $ldaputils    = true
  $ldaputilspkg = $::osfamily ? {
    Debian  => 'ldap-utils',
    default => 'openldap-clients',
  }
}
