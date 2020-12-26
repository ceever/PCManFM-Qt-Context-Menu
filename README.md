# PCManFM-Qt Context Menu

**Various context menus (i.e. right click menus) for LXQT's file manager**

A great Linux distribution: https://lxqt.org/ or https://lubuntu.me/

Copyright © 2020 Andrew Jackson (https://github.com/ceever ... ceever@web.de)

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.



**SCREENSHOTS:**

PDF actions:<br/>
<p><img src="gfx/pdf.png"></p>

---

VLC enqueue files and folders:<br/>
<p><img src="gfx/vlc.png"></p>

---

Mount .iso, .nrg, .bin, .img, .mdf, .sdX, ...<br/>
<p><img src="gfx/mount.png"></p>

---

Bulk rename (pattern, substitute, case replacement):<br/>
<p><img src="gfx/bulk.png"></p>
<p><img src="gfx/bulk_rename.png"></p>

---
**BUGS & REQUESTS**

Send me an email or open a ticket on github.

---
**INSTALLATION:**

Put the relevant *.desktop* file under (create if missing):
* Linux (all users): /usr/share/file-manager/actions/
* Linux (current user): ~/.local/share/file-manager/actions/

Put the required scripts (executed by the associated *.desktop* file) under:
* Linux (all users): /usr/share/file-manager/
* Linux (current user): ~/.local/share/file-manager/

You might have to render the scripts executeable with "chmod +x SCRIPT" before they work. You can actually place them where you wnat, you just need to make sure to modify the "EXEC=" in the associated *.desktop* file accordingly.

Restart PCManFM-Qt: killall -9 pcmanfm-qt

---
**EXPLANATION & USAGE:**
*.desktop* files are text files under Linux that generally specify a certain program executable. But they are also used for autostart topics (/etc/xdg/autostart) or for filemanager actions, often with Nautilus (GNOME) but also with PCManFM-Qt (LXQt).

**Scripts:**
* The scripts are very simply and you can modify them if required. You might even replace programs that are not on your system by your prefered alternative.
* The scripts are needed due to the limitation of .desktop files wrt. the "EXEC=" parameter, which do not accept complex scripts.
* **Note**, if you place the scripts under *~/.local/share/file-manager/* you will have to modify the path in the *.desktop* file to your profile path accordingly.

**Dependencies:**
For the specific scripts/context menu to work, they require the following apps/programs:

* PDF: ps2pdf => **ghostscript**
* PDF: gs => **ghostscript**
* PDF: rotate => **pdftk**
* PDF: count => **zenity**, **poppler-utils**
* Mount disk => **udisksctl**
* Bulk rename => **python3**

If not yet installed on your system, install via:
<pre>sudo apt install ghostscript pdftk zenity poppler-utils udisksctl python3</pre>

**Bulk rename:**
* The original can be found here: https://github.com/trhura/nautilus-renamer or https://launchpad.net/nautilus-renamer/+download
* I modified slightly it to have an overwrite option included.

**FileManager-Actions:**
* A convenient tool to create context menu actions, in case you are uncomfortable with all the options to put into the *.desktop* (text) file.
* Install: <pre>sudo apt install filemanager-actions</pre>

**Further reading:**
* The *.desktop* file specification in general: https://specifications.freedesktop.org/desktop-entry-spec/latest/ and specifically https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s06.html
* Context menues (aka custom actions) under LXQt: https://wiki.ubuntuusers.de/PCMan_File_Manager/Benutzerdefinierte_Aktionen/ (German)
* FileManager-Actions: https://gitlab.gnome.org/GNOME/filemanager-actions, https://wiki.ubuntuusers.de/FileManager-Actions/
* How I discovered the sub-menu option: http://bernaerts.dyndns.org/linux/76-gnome/344-nautilus-new-document-creation-menu/ or <a href="sups/bernaerts-nicolas.fr.html" target="_blank">index.html backup</a> (in case the original website is offline)
  
**More examples:**
* https://askubuntu.com/questions/444305/add-open-folder-as-root-to-pcman-file-managers-context-menu
* https://unix.stackexchange.com/questions/430705/add-custom-menu-action-to-caja-file-manager
* https://wiki.manjaro.org/index.php/PCmanFM-Qt
* https://www.linuxquestions.org/questions/bodhi-92/fresh-install-a-couple-of-issues-to-deal-with-4175563768/
* http://cipricuslinux.blogspot.com/2015/06/add-open-folder-as-root-to-pcman-file.html
* https://ubuntuplace.info/questions/344492/add-a-new-nautilus-context-menu-action-without-using-nautilus-actions (French)
