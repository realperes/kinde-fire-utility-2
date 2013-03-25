args = WScript.Arguments.Count
ver = "1.1"
udate = "[24/3/2013]"

Function Help()
	WScript.Echo "RDC - WINGET-DL V" +ver
	WScript.Echo ""
	WScript.Echo "HTTP Downloader in VBScript"
	WScript.Echo "USAGE: winget-dl.exe [OPTION]... [SUBOPTION]"
	WScript.Echo ""
	WScript.Echo "General:"
	WScript.Echo "	--help                     Show this help page."
	WScript.Echo "	--version                  Show the version."
	WScript.Echo "	URL        [filename]      Download File."
	WScript.Echo ""
	WScript.Echo "Email bug reports and suggestions to <allardj64@gmail.com>"
	WScript.Quit(0)
End Function

Function sec_arg()
	' We have no save name, exit.
	WScript.Echo "E: Missing Save Name."
	WScript.Quit(1)
End Function

Function version()
	' Give 'em the version.
	WScript.Echo "RDC - WINGET-DL V" +ver
	WScript.Echo ""
	WScript.Echo "Version: " & ver & " - " +udate
	WScript.Quit(0)
End Function
 
' Usage
if args < 1 then
	Help
end If

If WScript.Arguments.Item(0) = "--version" Then 
	version
End If 

If args < 2 Then
	sec_arg
End If
 
If WScript.Arguments.Item(0) = "--help" Then
	Help
End If
 
Download WScript.Arguments.Item(0), WScript.Arguments.Item(1)
 
Sub Download (strLink, strSaveTo)	 
 	 WScript.Echo "WINGET-DL"
 	 WScript.Echo "-------------"
 	 WScript.Echo "Download: " & strLink
 	 WScript.Echo "Save to:  " & strSaveTo
 	 WScript.Echo "-------------"
 	 WScript.Echo "Downloading..."
 	 WScript.Echo ""
	
     ' Create an HTTP object
     Set objHTTP = CreateObject( "WinHttp.WinHttpRequest.5.1" )
 
     ' Download the specified URL
     objHTTP.Open "GET", strLink, False
     objHTTP.Send
     
          Set objFSO = CreateObject("Scripting.FileSystemObject")
	  If objFSO.FileExists(WScript.Arguments.Item(1)) Then
	  	objFSO.DeleteFile(WScript.Arguments.Item(1))
	  End If
 
      If objHTTP.Status = 200 Then
    	Dim objStream
	    Set objStream = CreateObject("ADODB.Stream")
	    With objStream
		    .Type = 1 'adTypeBinary
		    .Open
		    .Write objHTTP.ResponseBody
		    .SaveToFile strSaveTo
		    .Close
	    End With
	    set objStream = Nothing
	  End If
	  
	  If objFSO.FileExists(strSaveTo) Then
	  	WScript.Echo "Download `" & strSaveTo & "` completed successfuly."
	  End If 
End Sub