# GetFreeCourses Automatic Decoder
Windows 10 powershell script to automatically decode the Base64 link and open the url in your browser

## Dependencies
- [7-Zip](https://www.7-zip.org/download.html), You will need it installed on your Windows, the script will find it automatically
- [Google Drive CLI Client](https://github.com/gdrive-org/gdrive)
- Powershell, duh

## Usage
1. Download the files from the GetFreeCourses webpage
2. Download the Google Drive CLI and rename it as ``gdrive.exe``
3. Download the script and it in your browser's download directory

``` WARNING: It will try to execute for every .zip file in your directory, so it's not my problem if you end up with missing files or problems, the script is AS-IS ```

## To do
- [ ] Parameters so it automatically deletes the original file too
- [ ] Error detection (like 7-Zip missing from the system / stop when an error pops out)
- [ ] Make a summary on what failed and what was a success
- [ ] Download automatically dependencies (Google drive CLI)