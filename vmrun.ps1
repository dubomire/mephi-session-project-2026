$vmName = 'mephi-2026'
$vmDir = 'C:\VMs\mephi-2026'
$isoPath = '<put yor path to ISO file here>'

if (-not (Test-Path -LiteralPath $isoPath -PathType Leaf)) {
    throw "ISO не найден по пути $isoPath"
}

Get-VMSwitch -Name 'Default Switch' -ErrorAction Stop | Out-Null
New-Item -ItemType Directory -Path $vmDir -Force | Out-Null

$vmParams = @{
    Name               = $vmName
    Generation         = 2
    MemoryStartupBytes = 4GB
    Path               = $vmDir
    NewVHDPath         = Join-Path $vmDir 'system.vhdx'
    NewVHDSizeBytes    = 32GB
    SwitchName         = 'Default Switch'
}

New-VM @vmParams -ErrorAction Stop
Set-VMProcessor -VMName $vmName -Count 2

$dvd = Add-VMDvdDrive -VMName $vmName -Path $isoPath -Passthru
Set-VMFirmware -VMName $vmName -FirstBootDevice $dvd -EnableSecureBoot Off

vmconnect.exe localhost $vmName