# Netzwerk-Informationen auslesen
$networkConfigs = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled = True"

$networkConfigs = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "IPEnabled = True"

foreach ($config in $networkConfigs) {
    [PSCustomObject]@{
        "Hostname"        = $env:COMPUTERNAME
        "Schnittstelle"   = $config.Description
        "IP-Adresse"      = $config.IPAddress[0]
        "Subnetzmaske"    = $config.IPSubnet[0]
        "Standardgateway" = if ($config.DefaultIPGateway) { $config.DefaultIPGateway[0] } else { "Kein Gateway" }
        "DNS-Server"      = if ($config.DNSServerSearchOrder) { $config.DNSServerSearchOrder -join ", " } else { "Kein DNS" }
        "DHCP aktiv"      = $config.DHCPEnabled
    }
}