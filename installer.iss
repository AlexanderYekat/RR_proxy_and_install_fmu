; Installation script for proxy service
#define MyAppName "proxy_fmu"
#define MyAppVersion "1.0"
#define MyAppPublisher "CTO KSM"
#define MyAppExeName "proxy_fmu.exe"

[Setup]
; Unique application identifier for Windows
AppId={{B8F62C26-D0A9-4F19-9B7C-3A5E89C7B5E9}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=output
OutputBaseFilename=proxy_service_setup
Compression=lzma
SolidCompression=yes
; Administrator rights required for service installation
PrivilegesRequired=admin
; Minimum supported Windows version
MinVersion=5.1

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Copy main executable file
Source: "proxy_fmu.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Create Start Menu shortcut
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"

[Run]
; Install and start service after installation
Filename: "{app}\{#MyAppExeName}"; Parameters: "install"; Flags: runhidden waituntilterminated; StatusMsg: "Installing service..."
Filename: "{app}\{#MyAppExeName}"; Parameters: "start"; Flags: runhidden waituntilterminated; StatusMsg: "Starting service..."

[UninstallRun]
; Stop and remove service during uninstallation
Filename: "{app}\{#MyAppExeName}"; Parameters: "stop"; Flags: runhidden waituntilterminated
Filename: "{app}\{#MyAppExeName}"; Parameters: "uninstall"; Flags: runhidden waituntilterminated

[Code]
// Function to check if service is running before uninstallation
function InitializeUninstall(): Boolean;
var
  ResultCode: Integer;
begin
  Result := True;
  // Try to stop service before uninstallation
  Exec(ExpandConstant('{app}\{#MyAppExeName}'), 'stop', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  // Give service time to stop
  Sleep(2000);
end;

// Function to check before installation
function InitializeSetup(): Boolean;
begin
  Result := True;
  // Additional pre-installation checks can be added here
end;
