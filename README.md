# 설명
Synology NAS에서 자동으로 Plex 미디어 서버를 업데이트합니다

# How to
Download the script and put it into a Scheduled Task
---Setup Download Script---
ssh into your nas
execute: 
bash <(curl -s https://raw.githubusercontent.com/kamilake/plexupdate/master/plexupdate.sh)
---Setup Update Scheduler---
#Comment: Go back to Synology Console
Open Control Panel
Open Task Scheduler
Click Create ... Scheduled Task ... User-defined script
Enter Task as Update Plex
Click Schedule Tab
Change Schedule to fit needs
Click Task Settings Tab
Enter User-defined script as bash /volume1/Scripts/plexupdate.sh
Click OK

Thanks to https://forums.plex.tv/u/j0nsplex

# Todo
Merge with 
https://gist.github.com/seanhamlin/dcde16a164377dca87a798a4c2ea051c
https://forums.plex.tv/t/script-to-auto-update-plex-on-synology-nas-rev4/479748/36?u=martino
