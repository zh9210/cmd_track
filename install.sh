#!/bin/bash
cp cmd_track.conf /etc/rsyslog.d/
cp cmd_profile.sh /etc/profile.d/
service rsyslog restart
source /etc/profile
