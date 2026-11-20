$dataVhd = 'C:\VMs\mephi-2026\mephi-web.vhdx'

New-VHD -Path $dataVhd -SizeBytes 4GB -Dynamic -ErrorAction Stop
Add-VMHardDiskDrive -VMName 'mephi-2026' -ControllerType SCSI -Path $dataVhd -ErrorAction Stop

Get-VMHardDiskDrive -VMName 'mephi-2026' |
    Format-Table ControllerType, ControllerNumber, ControllerLocation, Path