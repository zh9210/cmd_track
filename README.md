# cmd_track
log the terminal history to the log in realtimes.

Install:  
1. Copy the cmd_track.conf to the /etc/rsyslog.d/  
#cp cmd_track.conf /etc/rsyslog.d/
2. Copy the cmd_profile.sh to the /etc/profile.d/  
#cp cmd_profile.sh /etc/profile.d/
3. Restart the rsyslog services  
#service rsyslog restart
4. Relogin and input some some command then check the logfile.

PS:
1. The scripts need use pstree, so need install psmisc .
2. The source-highlight also need to install, get the better looks when using less.

