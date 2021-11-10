# Breach-RIP

Breach-RIP is a modified version of [breach-parse](https://github.com/hmaverickadams/breach-parse) by Heath Adams that runs significantly faster thanks to [ripgrep](https://github.com/BurntSushi/ripgrep) and outputs more information! 

Breach-RIP works best when ran against several databases. 

I highly recommend cleaning up your lists prior to running Breach-RIP. While easy to modify, it will grep the third delimiter of the main-list for the password. While this works perfectly for some lists, it may not with others. I strongly recommend referring to the main-list if your password list looks funky!

## Requirements

There are only two requirements to run breach-rip.. Ripgrep and a breach list. 

Install Ripgrep: `sudo apt-get install ripgrep`

## Usage
If you don't store breach lists in `/opt/breaches`, specify the location via the fourth argument: 
`breach-parse @[COMPANY].com [COMPANY].txt /home/kali/latestbreaches/`

## Outputs
* Main output
* Emails
* Usernames
* Passwords

## Additional Information 

A breached password list is available for download here: \
`magnet:?xt=urn:btih:7ffbcd8cee06aba2ce6561688cf68ce2addca0a3&dn=BreachCompilation&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Fglotorrents.pw%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337`
