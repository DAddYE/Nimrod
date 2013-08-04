#
#
#            Nimrod's Runtime Library
#        (c) Copyright 2006 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

# ---------------------------------------------------------------------
#  shfolder.dll is distributed standard with IE5.5, so it should ship
#  with 2000/XP or higher but is likely to be installed on NT/95/98 or
#  ME as well.  It works on all these systems.
#
#  The info found here is also in the registry:
#  HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\
#  HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\
#
#  Note that not all CSIDL_* constants are supported by shlfolder.dll,
#  they should be supported by the shell32.dll, though again not on all
#  systems.
#  ---------------------------------------------------------------------

{.deadCodeElim: on.}

import 
  windows

const 
  LibName* = "SHFolder.dll"

const 
  CsidlPrograms* = 0x00000002 # %SYSTEMDRIVE%\Program Files                                      
  CsidlPersonal* = 0x00000005 # %USERPROFILE%\My Documents                                       
  CsidlFavorites* = 0x00000006 # %USERPROFILE%\Favorites                                          
  CsidlStartup* = 0x00000007 # %USERPROFILE%\Start menu\Programs\Startup                        
  CsidlRecent* = 0x00000008  # %USERPROFILE%\Recent                                             
  CsidlSendto* = 0x00000009  # %USERPROFILE%\Sendto                                             
  CsidlStartmenu* = 0x0000000B # %USERPROFILE%\Start menu                                         
  CsidlMymusic* = 0x0000000D # %USERPROFILE%\Documents\My Music                                 
  CsidlMyvideo* = 0x0000000E # %USERPROFILE%\Documents\My Videos                                
  CsidlDesktopdirectory* = 0x00000010 # %USERPROFILE%\Desktop                                            
  CsidlNethood* = 0x00000013 # %USERPROFILE%\NetHood                                            
  CsidlTemplates* = 0x00000015 # %USERPROFILE%\Templates                                          
  CsidlCommonStartmenu* = 0x00000016 # %PROFILEPATH%\All users\Start menu                               
  CsidlCommonPrograms* = 0x00000017 # %PROFILEPATH%\All users\Start menu\Programs                      
  CsidlCommonStartup* = 0x00000018 # %PROFILEPATH%\All users\Start menu\Programs\Startup              
  CsidlCommonDesktopdirectory* = 0x00000019 # %PROFILEPATH%\All users\Desktop                                  
  CsidlAppdata* = 0x0000001A # %USERPROFILE%\Application Data (roaming)                         
  CsidlPrinthood* = 0x0000001B # %USERPROFILE%\Printhood                                          
  CsidlLocalAppdata* = 0x0000001C # %USERPROFILE%\Local Settings\Application Data (non roaming)      
  CsidlCommonFavorites* = 0x0000001F # %PROFILEPATH%\All users\Favorites                                
  CsidlInternetCache* = 0x00000020 # %USERPROFILE%\Local Settings\Temporary Internet Files            
  CsidlCookies* = 0x00000021 # %USERPROFILE%\Cookies                                            
  CsidlHistory* = 0x00000022 # %USERPROFILE%\Local settings\History                             
  CsidlCommonAppdata* = 0x00000023 # %PROFILESPATH%\All Users\Application Data                        
  CsidlWindows* = 0x00000024 # %SYSTEMROOT%                                                     
  CsidlSystem* = 0x00000025  # %SYSTEMROOT%\SYSTEM32 (may be system on 95/98/ME)                
  CsidlProgramFiles* = 0x00000026 # %SYSTEMDRIVE%\Program Files                                      
  CsidlMypictures* = 0x00000027 # %USERPROFILE%\My Documents\My Pictures                           
  CsidlProfile* = 0x00000028 # %USERPROFILE%                                                    
  CsidlProgramFilesCommon* = 0x0000002B # %SYSTEMDRIVE%\Program Files\Common                               
  CsidlCommonTemplates* = 0x0000002D # %PROFILEPATH%\All Users\Templates                                
  CsidlCommonDocuments* = 0x0000002E # %PROFILEPATH%\All Users\Documents                                
  CsidlCommonAdmintools* = 0x0000002F # %PROFILEPATH%\All Users\Start Menu\Programs\Administrative Tools 
  CsidlAdmintools* = 0x00000030 # %USERPROFILE%\Start Menu\Programs\Administrative Tools           
  CsidlCommonMusic* = 0x00000035 # %PROFILEPATH%\All Users\Documents\my music                       
  CsidlCommonPictures* = 0x00000036 # %PROFILEPATH%\All Users\Documents\my pictures                    
  CsidlCommonVideo* = 0x00000037 # %PROFILEPATH%\All Users\Documents\my videos                      
  CsidlCdburnArea* = 0x0000003B # %USERPROFILE%\Local Settings\Application Data\Microsoft\CD Burning 
  CsidlProfiles* = 0x0000003E # %PROFILEPATH%                                                    
  CsidlFlagCreate* = 0x00008000 # (force creation of requested folder if it doesn't exist yet)     
                                  # Original entry points 

proc sHGetFolderPathA*(Ahwnd: Hwnd, Csidl: Int, Token: THandle, Flags: Dword, 
                       Path: Cstring): Hresult{.stdcall, dynlib: LibName, 
    importc: "SHGetFolderPathA".}
proc sHGetFolderPathW*(Ahwnd: Hwnd, Csidl: Int, Token: THandle, Flags: Dword, 
                       Path: Cstring): Hresult{.stdcall, dynlib: LibName, 
    importc: "SHGetFolderPathW".}
proc sHGetFolderPath*(Ahwnd: Hwnd, Csidl: Int, Token: THandle, Flags: Dword, 
                      Path: Cstring): Hresult{.stdcall, dynlib: LibName, 
    importc: "SHGetFolderPathA".}
type 
  PFNSHGetFolderPathA* = proc (Ahwnd: Hwnd, Csidl: Int, Token: THandle, 
                               Flags: Dword, Path: Cstring): Hresult{.stdcall.}
  PFNSHGetFolderPathW* = proc (Ahwnd: Hwnd, Csidl: Int, Token: THandle, 
                               Flags: Dword, Path: Cstring): Hresult{.stdcall.}
  PFNSHGetFolderPath* = PFNSHGetFolderPathA
  TSHGetFolderPathA* = PFNSHGetFolderPathA
  TSHGetFolderPathW* = PFNSHGetFolderPathW
  TSHGetFolderPath* = TSHGetFolderPathA

